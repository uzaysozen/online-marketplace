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
        if data.message_id
          messageContent = document.getElementById('message-' + data.message_id)
          messageContent.remove()
        else
          messageContainer = document.getElementById('messages')
          messageContainer.innerHTML = messageContainer.innerHTML + data.html
          messageContainer.scrollTo(0, messageContainer.scrollHeight)

document.addEventListener 'turbolinks:load', load

