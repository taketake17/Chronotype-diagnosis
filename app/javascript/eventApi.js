import { getCalendar } from './calendar.js';

export function createSchedule(scheduleData, token) {
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
      getCalendar().refetchEvents();
    })
    .catch(error => console.error('Error:', error));
}

export function updateSchedule(id, scheduleData, token) {
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
      getCalendar().refetchEvents();
    })
    .catch(error => console.error('Error:', error));
}

export function deleteEvent(event, token) {
  fetch(`/calendar/${event.id}`, {
    method: 'DELETE',
    headers: {
      'Accept': 'application/json',
      'X-CSRF-Token': token
    },
  })
    .then(response => response.json())
    .then(() => {
      getCalendar().refetchEvents();
    })
    .catch(error => console.error('Error:', error));
}
