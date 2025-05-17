export function toggleFormVisibility(formId, show) {
    const form = document.getElementById(formId);
    if (form) {
      form.style.display = show ? 'block' : 'none';
    }
  }
  
  export function generateTimeOptions() {
    const startTime = document.getElementById('startTime');
    const endTime = document.getElementById('endTime');
    if (!startTime || !endTime) return;
    startTime.innerHTML = '';
    endTime.innerHTML = '';
    for (let i = 0; i < 24; i++) {
      for (let j = 0; j < 60; j += 30) {
        const time = `${i.toString().padStart(2, '0')}:${j.toString().padStart(2, '0')}`;
        startTime.options.add(new Option(time, time));
        endTime.options.add(new Option(time, time));
      }
    }
  }
  