import { deleteEvent } from './eventApi.js';
import { editEvent } from './eventform.js';
import { getToken } from './calendar.js';
import { toggleFormVisibility } from './utils.js';

export function showEventDetails(info) {
    if (info && info.event) {
        const detailsForm = document.getElementById('eventDetailsForm');
        document.getElementById('eventDetailTitle').textContent = info.event.title;
        document.getElementById('eventDetailStart').textContent = info.event.start.toLocaleString();
        document.getElementById('eventDetailEnd').textContent = info.event.end ? info.event.end.toLocaleString() : 'N/A';
        const contentElement = document.getElementById('eventDetailContent');
        if (contentElement) {
            contentElement.textContent = info.event.extendedProps.content || '(未設定)';
        }
        const editButton = document.getElementById('editEventButton');
        const deleteButton = document.getElementById('deleteEventButton');

        if (info.event.extendedProps && info.event.extendedProps.isDefault) {
            editButton.style.display = 'none';
            deleteButton.style.display = 'none';
        } else {
            editButton.style.display = 'inline-block';
            deleteButton.style.display = 'inline-block';
        }

        deleteButton.replaceWith(deleteButton.cloneNode(true));
        const freshDeleteButton = document.getElementById('deleteEventButton');
        freshDeleteButton.addEventListener('click', function () {
            if (info.event.extendedProps && info.event.extendedProps.isDefault) {
                alert('デフォルトスケジュールは削除できません。');
            } else {
                if (confirm('この予定を削除してもよろしいですか？')) {
                    deleteEvent(info.event, getToken());
                    toggleFormVisibility('eventDetailsForm', false);
                }
            }
        });

        editButton.replaceWith(editButton.cloneNode(true));
        const freshEditButton = document.getElementById('editEventButton');
        freshEditButton.addEventListener('click', function () {
            if (info.event.extendedProps && info.event.extendedProps.isDefault) {
                alert('デフォルトスケジュールは編集できません。');
            } else {
                editEvent(info.event);
            }
        });

        toggleFormVisibility('eventDetailsForm', true);
        detailsForm.style.position = 'absolute';
        detailsForm.style.left = '50%';
        detailsForm.style.top = '50%';
        detailsForm.style.transform = 'translate(-50%, -50%)';

        let detailsFormClickListener = function (e) {
            if (!detailsForm.contains(e.target)) {
                toggleFormVisibility('eventDetailsForm', false);
                document.removeEventListener('click', detailsFormClickListener);
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
