import { createSchedule, updateSchedule } from './eventApi.js';
import { getSelectedInfo, setSelectedInfo, getToken } from './calendar.js';
import { toggleFormVisibility } from './utils.js';

export function openForm(date) {
  toggleFormVisibility('eventForm', true);
  const eventForm = document.getElementById('eventForm');
  eventForm.style.position = 'fixed';
  eventForm.style.left = '50%';
  eventForm.style.top = '50%';
  eventForm.style.transform = 'translate(-50%, -50%)';
  document.getElementById('eventName').value = '';
  document.getElementById('startTime').value = date.toTimeString().slice(0, 5);
  document.getElementById('endTime').value = new Date(date.getTime() + 30 * 60 * 1000).toTimeString().slice(0, 5);
  document.getElementById('eventContent').value = '';
}

export function handleSaveEvent(e) {
  if (e) e.preventDefault();
  const eventName = document.getElementById('eventName').value;
  const selectedStartTime = document.getElementById('startTime').value;
  const selectedEndTime = document.getElementById('endTime').value;
  const eventContent = document.getElementById('eventContent').value;
  const selectedInfo = getSelectedInfo();

  if (eventName && selectedInfo) {
    let startDate = new Date(selectedInfo.start);
    let endDate = new Date(selectedInfo.end);

    const [startHours, startMinutes] = selectedStartTime.split(':');
    startDate.setHours(startHours, startMinutes);
    const [endHours, endMinutes] = selectedEndTime.split(':');
    endDate.setHours(endHours, endMinutes);

    const scheduleData = {
      title: eventName,
      start_time: startDate.toISOString(),
      end_time: endDate.toISOString(),
      content: eventContent
    };

    if (selectedInfo.event) {
      updateSchedule(selectedInfo.event.id, scheduleData, getToken());
    } else {
      createSchedule(scheduleData, getToken());
    }
    toggleFormVisibility('eventForm', false);
    setSelectedInfo(null);
  } else {
    alert('予定名を入力してください');
  }
}

export function editEvent(event) {
  document.getElementById('eventName').value = event.title;
  const startTime = new Date(event.start).toLocaleTimeString('ja-JP', { hour: '2-digit', minute: '2-digit' });
  const endTime = new Date(event.end).toLocaleTimeString('ja-JP', { hour: '2-digit', minute: '2-digit' });
  document.getElementById('startTime').value = startTime;
  document.getElementById('endTime').value = endTime;
  document.getElementById('eventContent').value = event.extendedProps.content || '';
  setSelectedInfo({ event: event, start: event.start, end: event.end });
  toggleFormVisibility('eventDetailsForm', false);
  toggleFormVisibility('eventForm', true);
}
