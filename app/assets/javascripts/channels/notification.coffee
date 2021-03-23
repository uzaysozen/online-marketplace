load = ->
  conversation_element = document.getElementById('user-id')
  user_id = conversation_element.getAttribute('data-user-id')
  if user_id == ""
    App.cable.disconnect()
  else
    App.room = App.cable.subscriptions.create {
      channel: 'NotificationChannel'
      user_id: user_id
    },
      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
          
notice = (content) -> 
  $alert = $('<div>').addClass('toast');
  $alert.attr('role', 'alert').attr('aria-live', 'assertive').attr('data-delay', '3000').attr('aria-atomic');
  $header = $('<div>').addClass('toast-header');
  $header.append('<strong class="mr-auto">Message</strong>
          <small class="text-muted">11 mins ago</small>
          <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
          <span aria-hidden="true">&times;</span>
          </button>');
  $body = $('<div>').addClass('toast-body').append(content);

  $alert.append($header).append($body);

  $('.toasts').prepend($alert)
  $alert.toast('show')

document.addEventListener 'turbolinks:load', load

