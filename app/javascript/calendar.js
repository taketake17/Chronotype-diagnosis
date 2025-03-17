import { Calendar } from '@fullcalendar/core';
import interactionPlugin from "@fullcalendar/interaction";
import timeGridPlugin from '@fullcalendar/timegrid';

// グローバル変数として宣言
let calendar; 
let selectedInfo = null;

// 時間選択用のオプションを生成
function generateTimeOptions() {
    const startTime = document.getElementById('startTime');
    const endTime = document.getElementById('endTime');

    for (let i = 0; i < 24; i++) {
      for (let j = 0; j < 60; j += 30) {
        const time = `${i.toString().padStart(2, '0')}:${j.toString().padStart(2, '0')}`;
        startTime.options.add(new Option(time, time));
        endTime.options.add(new Option(time, time));
      }
    }
}

// 保存ボタンがクリックされたときの処理
function handleSaveEvent() {
    const eventName = document.getElementById('eventName').value;
    const selectedStartTime = document.getElementById('startTime').value;
    const selectedEndTime = document.getElementById('endTime').value;
  
    if (eventName && selectedInfo) {
      let startDate, endDate;
  
      if (selectedInfo.event) {
        // 既存のイベントを編集する場合
        startDate = new Date(selectedInfo.event.start);
        endDate = new Date(selectedInfo.event.end);
      } else {
        // 新規イベントを追加する場合
        startDate = new Date(selectedInfo.start);
        endDate = new Date(selectedInfo.end);
      }
  
      // 時間を設定
      const [startHours, startMinutes] = selectedStartTime.split(':');
      startDate.setHours(startHours, startMinutes);
  
      const [endHours, endMinutes] = selectedEndTime.split(':');
      endDate.setHours(endHours, endMinutes);
  
      if (selectedInfo.event) {
        // 既存のイベントを更新
        selectedInfo.event.remove();
      }
  
      // カレンダーにイベントを追加（新規追加または更新）
      calendar.addEvent({
        title: eventName,
        start: startDate.toISOString(),
        end: endDate.toISOString()
      });
  
      // フォームを非表示にしてリセット
      document.getElementById('eventForm').style.display = 'none';
      selectedInfo = null;
    } else {
      alert('予定名を入力してください');
    }
}

// DOMが読み込まれた後にカレンダーを初期化
document.addEventListener('DOMContentLoaded', function() {
    generateTimeOptions(); // 時間選択オプションを生成

    const calendarEl = document.getElementById('calendar');
    const eventForm = document.getElementById('eventForm');

    // カレンダーを初期化
    calendar = new Calendar(calendarEl, {
      plugins: [interactionPlugin, timeGridPlugin],
      initialView: 'timeGridWeek',
      selectable: true,

      // 日付範囲が選択されたときの処理
      select: function(info) {
        selectedInfo = info; // 選択された情報を保存

        // フォームを表示して位置を設定
        eventForm.style.display = 'block';
        eventForm.style.left = info.jsEvent.pageX + 'px';
        eventForm.style.top = info.jsEvent.pageY + 'px';

        // フォームの初期値を設定
        document.getElementById('eventName').value = '';
        document.getElementById('startTime').value = info.start.toTimeString().slice(0, 5);
        document.getElementById('endTime').value = info.end.toTimeString().slice(0, 5);
      },
      eventClick: function(info) {
        showEventDetails(info);
      }
    });

    calendar.render(); // カレンダーを描画

    // 保存ボタンにイベントリスナーを追加
    document.getElementById('saveEvent').addEventListener('click', handleSaveEvent);
});

function showEventDetails(info) {
    if (info && info.event) {
      const detailsForm = document.getElementById('eventDetailsForm');
      document.getElementById('eventDetailTitle').textContent = info.event.title;
      document.getElementById('eventDetailStart').textContent = info.event.start.toLocaleString();
      document.getElementById('eventDetailEnd').textContent = info.event.end ? info.event.end.toLocaleString() : 'N/A';
      
      // 編集ボタンのイベントリスナー
      document.getElementById('editEventButton').onclick = function() {
        editEvent(info.event, info.jsEvent);
      };
      
      // 削除ボタンのイベントリスナー
      document.getElementById('deleteEventButton').onclick = function() {
        deleteEvent(info.event);
      };
    
      // フォームを表示して位置を設定
      detailsForm.style.display = 'block';
      detailsForm.style.position = 'absolute';
      detailsForm.style.left = info.jsEvent.pageX + 'px';
      detailsForm.style.top = info.jsEvent.pageY + 'px';
  
      // フォーム外クリックで閉じる (遅延を追加)
      setTimeout(() => {
        document.addEventListener('click', closeDetailsForm);
      }, 0);
  
      // フォーム内クリックの伝播を停止
      detailsForm.addEventListener('click', function(e) {
        e.stopPropagation();
      });
    } else {
      console.error('Event information is missing');
    }
}
  
function closeDetailsForm(e) {
    const detailsForm = document.getElementById('eventDetailsForm');
    if (e.target !== detailsForm && !detailsForm.contains(e.target)) {
      detailsForm.style.display = 'none';
      document.removeEventListener('click', closeDetailsForm);
    }
}
  
function editEvent(event, jsEvent) {
    // 編集フォームに現在のイベント情報を設定
    document.getElementById('eventName').value = event.title;
    const startTime = new Date(event.start).toLocaleTimeString('ja-JP', { hour: '2-digit', minute: '2-digit' });
    const endTime = new Date(event.end).toLocaleTimeString('ja-JP', { hour: '2-digit', minute: '2-digit' });
    document.getElementById('startTime').value = startTime;
    document.getElementById('endTime').value = endTime;
  
    // 編集モードフラグを設定
    selectedInfo = { event: event };
  
    // 詳細フォームを非表示にし、編集フォームを表示
    document.getElementById('eventDetailsForm').style.display = 'none';
    document.getElementById('eventForm').style.display = 'block';
    document.getElementById('eventForm').style.left = jsEvent.pageX + 'px';
    document.getElementById('eventForm').style.top = jsEvent.pageY + 'px';
}
  
function deleteEvent(event) {
    if (confirm('この予定を削除してもよろしいですか？')) {
      event.remove();
      document.getElementById('eventDetailsForm').style.display = 'none';
    }
}
