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

document.addEventListener 'turbolinks:load', load

