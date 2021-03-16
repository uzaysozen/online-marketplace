load = ->
  conversation_element = document.getElementById('conversation-id')

  if conversation_element == null
    App.cable.disconnect()
  else
    conversation_id = conversation_element.getAttribute('data-conversation-id')
    
    for subscription in App.cable.subscriptions.subscriptions
      App.cable.subscriptions.remove(subscription)

    App.room = App.cable.subscriptions.create {
      channel: 'ConversationChannel'
      conversation_id: conversation_id
    },
      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        element = document.getElementById('user-id')
        user_id = Number(element.getAttribute('data-user-id'))

        html = undefined
        if user_id == data.message.sender_id
          html = data.my
        else
          html = data.their

        messageContainer = document.getElementById('messages')
        messageContainer.innerHTML = messageContainer.innerHTML + html

document.addEventListener 'turbolinks:load', load

