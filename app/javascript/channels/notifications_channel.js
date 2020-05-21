import consumer from "./consumer"

consumer.subscriptions.create("NotificationsChannel", {
  connected() {},
  disconnected() {},

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    // Prepend the list
    $("#notifications").prepend(data.notification)
    // Update the counter
    $('#notification-counter').text(
      parseInt($('#notification-counter').text()) + 1
    )

    // Ensure the bell icon shows a waiting notification
    $('#notification-indicator').show()

    if ($('#notification-container').is(':hidden')) {
      $('#notification-container').dropdown('toggle')
    }

    // Play the notification sound
    $('#notification-bell')[0].play()
  }
});
