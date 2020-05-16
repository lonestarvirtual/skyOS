import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
    connect() {
        let notification_count = parseInt($('#notification-counter').text())

        if (notification_count > 0) {
            $('#notification-indicator').show()
        }
    }

    delete(event) {
        event.preventDefault()
        event.stopPropagation()

        let id  = this.targets.find('id')
        let row = id.parentElement.parentElement

        this.mark_delete(id.value, row)
    }

    delete_all(event) {
        event.preventDefault()
        event.stopPropagation()

        this.mark_delete('all')
    }

    mark_delete(id, row = null) {
        let counter = document.getElementById('notification-counter')

        Rails.ajax({
            url:  '/notifications/' + id,
            type: 'delete',
            data: '',
            success: function (data) {
                if (row) {
                    // remove the notification
                    row.remove()
                }

                // update notification count
                let count = parseInt(counter.innerText)
                count = count - 1
                counter.innerText = count

                if (count === 0 || id === 'all') {
                    // empty the notifications
                    $('#notifications').empty()
                    // set counter to 0
                    $('#notification-counter').text(0)

                    $('#notification-indicator').hide()
                    $('#notification-container').dropdown('toggle')
                }
            }
        })
    }
}
