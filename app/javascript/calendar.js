import { Calendar } from '@fullcalendar/core';
import interactionPlugin from "@fullcalendar/interaction";
import timeGridPlugin from '@fullcalendar/timegrid';


document.addEventListener('DOMContentLoaded', function() {
  const calendarEl = document.getElementById('calendar');
  const calendar = new Calendar(calendarEl, {
    plugins: [interactionPlugin,timeGridPlugin],
    initialView: 'timeGridWeek',
    headerToolbar: {
      left: 'prev,next today',
      center: 'title',
      right: 'timeGridWeek,timeGridDay'
    },

    selectable: true,
    select: function (info) {
        alert("selected " + info.startStr + " to " + info.endStr);
    },
  });
  calendar.render();
});
