import consumer from "./consumer"

// Check meta tag to determine if this channel should attempt to connect
if ($("meta[name='current-pilot']").length > 0) {
  consumer.subscriptions.create("PirepsChannel", {
    connected() {
    },

    disconnected() {
    },

    received(data) {
      // Called when there's incoming data on the websocket for this channel
      if (parseInt(data.pending) > 0) {
        let old_count = parseInt($('#pending-pireps-count').text())
        let new_count = parseInt(data.pending)

        // Show the icon
        $('#pending-pireps').show()
        // Show the tooltip
        $('#pending-pireps-href').tooltip('show')

        // Update the badge count
        $('#pending-pireps-count').text(new_count)

        // Play the notification sound if the count went up
        if (new_count > old_count) {
          $('#pending-pireps-bell')[0].play()
        }
      } else {
        $('#pending-pireps-count').text(0)
        $('#pending-pireps-href').tooltip('hide')
        $('#pending-pireps').hide()
      }
    }
  });
}
