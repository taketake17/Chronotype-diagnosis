import { Calendar } from '@fullcalendar/core';
import interactionPlugin from "@fullcalendar/interaction";
import timeGridPlugin from '@fullcalendar/timegrid';

let calendar;
let selectedInfo = null;
let token = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content');

// フォームの表示・非表示を切り替える関数
function toggleFormVisibility(formId, show) {
  const form = document.getElementById(formId);
  if (form) {
    form.style.display = show ? 'block' : 'none';
  }
}

// 時間選択肢生成
function generateTimeOptions() {
  const startTime = document.getElementById('startTime');
  const endTime = document.getElementById('endTime');
  if (!startTime || !endTime) return;

  for (let i = 0; i < 24; i++) {
    for (let j = 0; j < 60; j += 30) {
      const time = `${i.toString().padStart(2, '0')}:${j.toString().padStart(2, '0')}`;
      startTime.options.add(new Option(time, time));
      endTime.options.add(new Option(time, time));
    }
  }
}

// イベント保存
function handleSaveEvent(e) {
  if (e) e.preventDefault();
  const eventName = document.getElementById('eventName').value;
  const selectedStartTime = document.getElementById('startTime').value;
  const selectedEndTime = document.getElementById('endTime').value;
  const eventContent = document.getElementById('eventContent').value; // 追加

  if (eventName && selectedInfo) {
    let startDate = new Date(selectedInfo.start);
    let endDate = new Date(selectedInfo.end);

    // 時間をセット
    const [startHours, startMinutes] = selectedStartTime.split(':');
    startDate.setHours(startHours, startMinutes);
    const [endHours, endMinutes] = selectedEndTime.split(':');
    endDate.setHours(endHours, endMinutes);

    const scheduleData = {
      title: eventName,
      start_time: startDate.toISOString(),
      end_time: endDate.toISOString(),
      content: eventContent // 追加
    };

    if (selectedInfo.event) {
      updateSchedule(selectedInfo.event.id, scheduleData);
    } else {
      createSchedule(scheduleData);
    }

    toggleFormVisibility('eventForm', false); // フォームを非表示にする
    selectedInfo = null;
  } else {
    alert('予定名を入力してください');
  }
}

// 新規作成
function createSchedule(scheduleData) {
  fetch('/calendar', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-CSRF-Token': token
    },
    body: JSON.stringify({ schedule: scheduleData }),
  })
    .then(response => response.json())
    .then(() => {
      calendar.refetchEvents(); // ← addEventは使わず、refetchEventsのみ
    })
    .catch(error => console.error('Error:', error));
}

// 更新
function updateSchedule(id, scheduleData) {
  fetch(`/calendar/${id}`, {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-CSRF-Token': token
    },
    body: JSON.stringify({ schedule: scheduleData }),
  })
    .then(response => response.json())
    .then(() => {
      calendar.refetchEvents();
    })
    .catch(error => console.error('Error:', error));
}

// 削除
function deleteEvent(event) {
  fetch(`/calendar/${event.id}`, {
    method: 'DELETE',
    headers: {
      'Accept': 'application/json',
      'X-CSRF-Token': token
    },
  })
    .then(response => response.json())
    .then(() => {
      calendar.refetchEvents();
      toggleFormVisibility('eventDetailsForm', false);
    })
    .catch(error => console.error('Error:', error));
}

// 詳細表示
function showEventDetails(info) {
  if (info && info.event) {
    const detailsForm = document.getElementById('eventDetailsForm');
    document.getElementById('eventDetailTitle').textContent = info.event.title;
    document.getElementById('eventDetailStart').textContent = info.event.start.toLocaleString();
    document.getElementById('eventDetailEnd').textContent = info.event.end ? info.event.end.toLocaleString() : 'N/A';

    // 追加：やりたいこと表示
    const contentElement = document.getElementById('eventDetailContent');
    if (contentElement) {
      contentElement.textContent = info.event.extendedProps.content || '(未設定)';
    }

    const editButton = document.getElementById('editEventButton');
    const deleteButton = document.getElementById('deleteEventButton');

    // デフォルトイベント判定
    if (info.event.extendedProps && info.event.extendedProps.isDefault) {
      editButton.style.display = 'none';
      deleteButton.style.display = 'none';
    } else {
      editButton.style.display = 'inline-block';
      deleteButton.style.display = 'inline-block';
    }

    // 既存のイベントリスナーをリセット
    deleteButton.replaceWith(deleteButton.cloneNode(true));
    const freshDeleteButton = document.getElementById('deleteEventButton');
    freshDeleteButton.addEventListener('click', function () {
      if (info.event.extendedProps && info.event.extendedProps.isDefault) {
        alert('デフォルトスケジュールは削除できません。');
      } else {
        if (confirm('この予定を削除してもよろしいですか？')) {
          deleteEvent(info.event);
        }
      }
    });

    editButton.replaceWith(editButton.cloneNode(true));
    const freshEditButton = document.getElementById('editEventButton');
    freshEditButton.addEventListener('click', function (e) {
      if (info.event.extendedProps && info.event.extendedProps.isDefault) {
        alert('デフォルトスケジュールは編集できません。');
      } else {
        editEvent(info.event, info.jsEvent);
      }
    });

    toggleFormVisibility('eventDetailsForm', true);
    detailsForm.style.position = 'absolute';
    detailsForm.style.left = '50%';
    detailsForm.style.top = '50%';
    detailsForm.style.transform = 'translate(-50%, -50%)';

    // 詳細フォーム外クリックで閉じる
    let detailsFormClickListener = null;
    if (detailsFormClickListener) {
      document.removeEventListener('click', detailsFormClickListener);
    }
    detailsFormClickListener = function (e) {
      if (!detailsForm.contains(e.target)) {
        toggleFormVisibility('eventDetailsForm', false);
        document.removeEventListener('click', detailsFormClickListener);
        detailsFormClickListener = null;
      }
    };
    setTimeout(() => {
      document.addEventListener('click', detailsFormClickListener);
    }, 0);

    info.jsEvent?.stopPropagation();
  } else {
    console.error('Event information is missing');
  }
}

// 編集
function editEvent(event, jsEvent) {
  if (event.extendedProps && event.extendedProps.isDefault) {
    alert('デフォルトスケジュールは編集できません。');
    return;
  }
  document.getElementById('eventName').value = event.title;
  const startTime = new Date(event.start).toLocaleTimeString('ja-JP', { hour: '2-digit', minute: '2-digit' });
  const endTime = new Date(event.end).toLocaleTimeString('ja-JP', { hour: '2-digit', minute: '2-digit' });
  document.getElementById('startTime').value = startTime;
  document.getElementById('endTime').value = endTime;

  // 追加：やりたいことをフォームにセット
  document.getElementById('eventContent').value = event.extendedProps.content || '';

  selectedInfo = { event: event, start: event.start, end: event.end };

  toggleFormVisibility('eventDetailsForm', false);
  toggleFormVisibility('eventForm', true);
  const eventForm = document.getElementById('eventForm');
  eventForm.style.position = 'absolute';
  eventForm.style.left = '50%';
  eventForm.style.top = '50%';
  eventForm.style.transform = 'translate(-50%, -50%)';
}

// Turboページロード時
document.addEventListener('turbo:load', function () {
  token = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content');
  generateTimeOptions();

  const calendarEl = document.getElementById('calendar');
  const eventForm = document.getElementById('eventForm');
  if (!calendarEl) return;

  if (calendar) calendar.destroy();

  let currentView = 'timeGridWeek'; // 現在の表示モードを保持

  calendar = new Calendar(calendarEl, {
    plugins: [interactionPlugin, timeGridPlugin],
    initialView: currentView, // 初期表示をcurrentViewに設定
    selectable: true,
    events: '/calendar.json',
    dateClick: function(info) {
      selectedInfo = {
        start: info.date,
        end: new Date(info.date.getTime() + 30 * 60 * 1000)
      };

      toggleFormVisibility('eventForm', true);
      eventForm.style.position = 'fixed';
      eventForm.style.left = '50%';
      eventForm.style.top = '50%';
      eventForm.style.transform = 'translate(-50%, -50%)';
      document.getElementById('eventName').value = '';
      document.getElementById('startTime').value = info.date.toTimeString().slice(0, 5);
      document.getElementById('endTime').value = new Date(info.date.getTime() + 30 * 60 * 1000).toTimeString().slice(0, 5);
      document.getElementById('eventContent').value = ''; // 追加：フォーム初期化
    },
    eventClick: function(info) {
      showEventDetails(info);
      // カーソルスタイルをリセット
      const allEvents = calendar.getEvents();
      allEvents.forEach(function (event) {
        const el = calendar.getEventById(event.id).el;
        if (el) el.style.cursor = 'pointer';
      });
      info.el.style.cursor = 'pointer';
    },
    eventDidMount: function(info) {
      // デフォルトイベントの色分け
      if (info.event.extendedProps && info.event.extendedProps.isDefault) {
        info.el.style.backgroundColor = '#C8E6C9'; // 緑系
        info.el.style.borderColor = '#FFE082';     // 黄系
        info.el.style.color = '#856404';           // 茶系
      }
    }
    // 必要に応じて他のFullCalendarオプションも追加
  });

  calendar.render();

  const saveEventButton = document.getElementById('saveEvent');
  if (saveEventButton) {
    const isTouchable = 'ontouchstart' in window || (window.DocumentTouch && document instanceof DocumentTouch);
    if (isTouchable) {
      saveEventButton.addEventListener('touchstart', handleSaveEvent);
    } else {
      saveEventButton.addEventListener('click', handleSaveEvent);
    }
  }

  // バツボタンでフォームを閉じる処理
  const closeBtn = document.getElementById('closeEventForm');
  if (closeBtn && eventForm) {
    closeBtn.addEventListener('click', function() {
      toggleFormVisibility('eventForm', false); // フォームを非表示にする
    });
  }

  // 表示切り替えボタン
  const toggleViewButton = document.getElementById('toggleViewButton');
  if (toggleViewButton) {
    toggleViewButton.addEventListener('click', function () {
      if (currentView === 'timeGridWeek') {
        calendar.changeView('timeGridDay');
        toggleViewButton.textContent = '週表示に切り替え';
        currentView = 'timeGridDay';
      } else {
        calendar.changeView('timeGridWeek');
        toggleViewButton.textContent = '日表示に切り替え';
        currentView = 'timeGridWeek';
      }
    });
  }
});

// Turboキャッシュ前にカレンダー破棄
document.addEventListener('turbo:before-cache', function () {
  if (calendar) {
    calendar.destroy();
    calendar = null;
  }
});
