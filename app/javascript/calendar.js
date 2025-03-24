import { Calendar } from '@fullcalendar/core';
import interactionPlugin from "@fullcalendar/interaction";
import timeGridPlugin from '@fullcalendar/timegrid';

let calendar;
let selectedInfo = null;

let token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

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

    document.getElementById('eventForm').style.display = 'none';
    selectedInfo = null;
  } else {
    alert('予定名を入力してください');
  }
}

function createSchedule(scheduleData) {
  fetch('/calendar', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
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

function updateSchedule(id, scheduleData) {
  fetch(`/calendar/${id}`, {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json',
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
    })
    .catch(error => console.error('Error:', error));
}

function deleteEvent(event) {
  if (confirm('この予定を削除してもよろしいですか？')) {
    fetch(`/calendar/${event.id}`, {
      method: 'DELETE',
      headers: {
        'X-CSRF-Token': token
      },
    })
      .then(response => response.json())
      .then(() => {
        event.remove();
        document.getElementById('eventDetailsForm').style.display = 'none';
      })
      .catch(error => console.error('Error:', error));
  }
}

document.addEventListener('turbo:load', function () {
  token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

  generateTimeOptions();



  const calendarEl = document.getElementById('calendar');
  const eventForm = document.getElementById('eventForm');

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
      eventForm.style.display = 'block';
      eventForm.style.left = info.jsEvent.pageX + 'px';
      eventForm.style.top = info.jsEvent.pageY + 'px';
      document.getElementById('eventName').value = '';
      document.getElementById('startTime').value = info.start.toTimeString().slice(0, 5);
      document.getElementById('endTime').value = info.end.toTimeString().slice(0, 5);
    },
    eventClick: function (info) {
      showEventDetails(info);
      info.el.style.cursor = 'pointer';

      const allEvents = calendar.getEvents();
      allEvents.forEach(function (event) {
        if (event !== info.event) {
          const el = calendar.getEventById(event.id).el;
          if (el) el.style.cursor = 'pointer';
        }
      });
    }
  });

  calendar.render();

  document.getElementById('saveEvent').addEventListener('click', handleSaveEvent);

  let detailsFormClickListener = null;

  function isDefaultEvent(event) {
    return event.extendedProps && event.extendedProps.isDefault;
  }

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

      editButton.onclick = function (e) {
        console.log('Edit button clicked'); // デバッグ用ログ
        if (isDefaultEvent(info.event)) {
          alert('デフォルトスケジュールは編集できません。');
        } else {
          console.log('Attempting to edit event:', info.event); // デバッグ用ログ
          editEvent(info.event, info.jsEvent);
        }
      };

      deleteButton.onclick = function () {
        if (isDefaultEvent(info.event)) {
          alert('デフォルトスケジュールは削除できません。');
        } else {
          if (confirm('この予定を削除してもよろしいですか？')) {
            deleteEvent(info.event);
          }
        }
      };

      detailsForm.style.display = 'block';
      detailsForm.style.position = 'absolute';
      detailsForm.style.left = info.jsEvent.pageX + 'px';
      detailsForm.style.top = info.jsEvent.pageY + 'px';
  
      if (detailsFormClickListener) {
        document.removeEventListener('click', detailsFormClickListener);
      }
  
      detailsFormClickListener = function(e) {
        if (!detailsForm.contains(e.target)) {
          detailsForm.style.display = 'none';
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

  function editEvent(event, jsEvent) {
    console.log('editEvent function called', event, jsEvent);
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

    document.getElementById('eventDetailsForm').style.display = 'none';
    document.getElementById('eventForm').style.display = 'block';
    document.getElementById('eventForm').style.left = jsEvent.pageX + 'px';
    document.getElementById('eventForm').style.top = jsEvent.pageY + 'px';
  }
});
