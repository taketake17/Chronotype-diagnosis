import { Calendar } from '@fullcalendar/core';
import interactionPlugin from "@fullcalendar/interaction";
import timeGridPlugin from '@fullcalendar/timegrid';

let calendar;
let selectedInfo = null;
let token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

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
function handleSaveEvent() {
  const eventName = document.getElementById('eventName').value;
  const selectedStartTime = document.getElementById('startTime').value;
  const selectedEndTime = document.getElementById('endTime').value;

  if (eventName && selectedInfo) {
    let startDate, endDate;
    if (selectedInfo.event) {
      startDate = new Date(selectedInfo.event.start);
      endDate = new Date(selectedInfo.event.end);
    } else {
      startDate = new Date(selectedInfo.start);
      endDate = new Date(selectedInfo.end);
    }

    const [startHours, startMinutes] = selectedStartTime.split(':');
    startDate.setHours(startHours, startMinutes);
    const [endHours, endMinutes] = selectedEndTime.split(':');
    endDate.setHours(endHours, endMinutes);

    const scheduleData = {
      title: eventName,
      start_time: startDate.toISOString(),
      end_time: endDate.toISOString()
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
      'Accept': 'application/json', // 追記
      'X-CSRF-Token': token
    },
    body: JSON.stringify({ schedule: scheduleData }),
  })
    .then(response => response.json())
    .then(data => {
      calendar.addEvent({
        id: data.id,
        title: scheduleData.title,
        start: scheduleData.start_time,
        end: scheduleData.end_time
      });
      calendar.refetchEvents();
    })
    .catch(error => console.error('Error:', error));
}

// 更新
function updateSchedule(id, scheduleData) {
  fetch(`/calendar/${id}`, {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json', // 追記
      'X-CSRF-Token': token
    },
    body: JSON.stringify({ schedule: scheduleData }),
  })
    .then(response => response.json())
    .then(() => {
      const event = calendar.getEventById(id);
      event.remove();
      calendar.addEvent({
        id: id,
        title: scheduleData.title,
        start: scheduleData.start_time,
        end: scheduleData.end_time
      });
      calendar.refetchEvents();
    })
    .catch(error => console.error('Error:', error));
}

// 削除
function deleteEvent(event) {
  fetch(`/calendar/${event.id}`, {
    method: 'DELETE',
    headers: {
      'Accept': 'application/json', // 追記
      'X-CSRF-Token': token
    },
  })
    .then(response => response.json())
    .then(() => {
      event.remove();
      toggleFormVisibility('eventDetailsForm', false); // 詳細フォームを非表示にする
      calendar.refetchEvents();
    })
    .catch(error => console.error('Error:', error));
}

// Turboページロード時
document.addEventListener('turbo:load', function () {
  token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  generateTimeOptions();

  const calendarEl = document.getElementById('calendar');
  const eventForm = document.getElementById('eventForm');
  if (!calendarEl) return;

  if (calendar) calendar.destroy();

  calendar = new Calendar(calendarEl, {
    plugins: [interactionPlugin, timeGridPlugin],
    initialView: 'timeGridWeek',
    selectable: true,
    events: '/calendar.json',
    eventDidMount: function (info) {
      if (info.event.extendedProps.isDefault) {
        info.el.style.backgroundColor = '#C8E6C9';
        info.el.style.borderColor = '#FFE082';
        info.el.style.color = '#856404';
      }
    },
    select: function (info) {
      selectedInfo = info;

      // フォーム表示位置を画面中央に固定
      toggleFormVisibility('eventForm', true);
      eventForm.style.position = 'fixed';
      eventForm.style.left = '50%';
      eventForm.style.top = '50%';
      eventForm.style.transform = 'translate(-50%, -50%)';
      document.getElementById('eventName').value = '';
      document.getElementById('startTime').value = info.start.toTimeString().slice(0, 5);
      document.getElementById('endTime').value = info.end.toTimeString().slice(0, 5);
    },
    eventClick: function (info) {
      showEventDetails(info);
      // カーソルスタイルをリセット
      const allEvents = calendar.getEvents();
      allEvents.forEach(function (event) {
        const el = calendar.getEventById(event.id).el;
        if (el) el.style.cursor = 'pointer';
      });
      info.el.style.cursor = 'pointer'; // 現在のイベントにもカーソルスタイルを適用
    }
  });

  calendar.render();

  document.getElementById('saveEvent').addEventListener('click', handleSaveEvent);

  let detailsFormClickListener = null;

  // デフォルト判定
  function isDefaultEvent(event) {
    return event.extendedProps && event.extendedProps.isDefault;
  }

  // 詳細表示
  function showEventDetails(info) {
    if (info && info.event) {
      const detailsForm = document.getElementById('eventDetailsForm');
      document.getElementById('eventDetailTitle').textContent = info.event.title;
      document.getElementById('eventDetailStart').textContent = info.event.start.toLocaleString();
      document.getElementById('eventDetailEnd').textContent = info.event.end ? info.event.end.toLocaleString() : 'N/A';

      const editButton = document.getElementById('editEventButton');
      const deleteButton = document.getElementById('deleteEventButton');

      if (isDefaultEvent(info.event)) {
        editButton.style.display = 'none';
        deleteButton.style.display = 'none';
      } else {
        editButton.style.display = 'inline-block';
        deleteButton.style.display = 'inline-block';
      }

      // まず既存のイベントリスナーをリセット
      deleteButton.replaceWith(deleteButton.cloneNode(true));
      const freshDeleteButton = document.getElementById('deleteEventButton');
      freshDeleteButton.addEventListener('click', function () {
        if (isDefaultEvent(info.event)) {
          alert('デフォルトスケジュールは削除できません。');
        } else {
          if (confirm('この予定を削除してもよろしいですか？')) {
            deleteEvent(info.event);
          }
        }
      });

      // 編集ボタンも同様にリセット
      editButton.replaceWith(editButton.cloneNode(true));
      const freshEditButton = document.getElementById('editEventButton');
      freshEditButton.addEventListener('click', function (e) {
        if (isDefaultEvent(info.event)) {
          alert('デフォルトスケジュールは編集できません。');
        } else {
          editEvent(info.event, info.jsEvent);
        }
      });

      toggleFormVisibility('eventDetailsForm', true);
      detailsForm.style.position = 'absolute';
      detailsForm.style.left = '50%'; // 画面中央に配置
      detailsForm.style.top = '50%';  // 画面中央に配置
      detailsForm.style.transform = 'translate(-50%, -50%)'; // 画面中央に配置

      // 詳細フォーム外クリックで閉じる
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

      info.jsEvent.stopPropagation();
    } else {
      console.error('Event information is missing');
    }
  }

  // 編集
  function editEvent(event, jsEvent) {
    if (isDefaultEvent(event)) {
      alert('デフォルトスケジュールは編集できません。');
      return;
    }
    document.getElementById('eventName').value = event.title;
    const startTime = new Date(event.start).toLocaleTimeString('ja-JP', { hour: '2-digit', minute: '2-digit' });
    const endTime = new Date(event.end).toLocaleTimeString('ja-JP', { hour: '2-digit', minute: '2-digit' });
    document.getElementById('startTime').value = startTime;
    document.getElementById('endTime').value = endTime;

    selectedInfo = { event: event };

    toggleFormVisibility('eventDetailsForm', false);
    toggleFormVisibility('eventForm', true);
    document.getElementById('eventForm').style.position = 'absolute';
    document.getElementById('eventForm').style.left = '50%'; // 画面中央に配置
    document.getElementById('eventForm').style.top = '50%';  // 画面中央に配置
    document.getElementById('eventForm').style.transform = 'translate(-50%, -50%)'; // 画面中央に配置
  }
});

// Turboキャッシュ前にカレンダー破棄
document.addEventListener('turbo:before-cache', function () {
  if (calendar) {
    calendar.destroy();
    calendar = null;
  }
});
