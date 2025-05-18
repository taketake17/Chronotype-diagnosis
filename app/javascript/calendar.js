import { Calendar } from '@fullcalendar/core';
import interactionPlugin from "@fullcalendar/interaction";
import timeGridPlugin from '@fullcalendar/timegrid';
import { openForm, handleSaveEvent } from './eventform.js';
import { showEventDetails } from './eventDetails.js';
import { generateTimeOptions, toggleFormVisibility } from './utils.js';

let calendar;
let selectedInfo = null;
let token = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content');

export function getCalendar() { return calendar; }
export function getSelectedInfo() { return selectedInfo; }
export function setSelectedInfo(info) { selectedInfo = info; }
export function getToken() { return token; }

document.addEventListener('turbo:load', function () {
  token = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content');
  generateTimeOptions();

  const calendarEl = document.getElementById('calendar');
  if (!calendarEl) return;

  if (calendar) calendar.destroy();

  let currentView = 'timeGridWeek';

  calendar = new Calendar(calendarEl, {
    plugins: [interactionPlugin, timeGridPlugin],
    initialView: currentView,
    selectable: true,
    events: '/calendar.json',
    dateClick: function (info) {
      selectedInfo = {
        start: info.date,
        end: new Date(info.date.getTime() + 30 * 60 * 1000)
      };
      openForm(info.date);
    },
    eventClick: function (info) {
      showEventDetails(info);
    },
    eventDidMount: function (info) {
      if (info.event.extendedProps && info.event.extendedProps.isDefault) {
        info.el.style.backgroundColor = '#C8E6C9';
        info.el.style.borderColor = '#FFE082';
        info.el.style.color = '#856404';
      }
    }
  });

  calendar.render();

  // 保存ボタン登録
  const saveEventButton = document.getElementById('saveEvent');
  if (saveEventButton) {
    saveEventButton.addEventListener('click', handleSaveEvent);
  }

  // フォーム閉じるボタン
  const closeBtn = document.getElementById('closeEventForm');
  const eventForm = document.getElementById('eventForm');
  if (closeBtn && eventForm) {
    closeBtn.addEventListener('click', function () {
      toggleFormVisibility('eventForm', false);
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

document.addEventListener('turbo:before-cache', function () {
  if (calendar) {
    calendar.destroy();
    calendar = null;
  }
});
