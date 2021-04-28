load = ->
  conversation_element = document.getElementById('conversation-id')

  if conversation_element == null
    App.cable.disconnect()
  else
    conversation_id = conversation_element.getAttribute('data-conversation-id')

    if !conversation_id
      return;

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

          if (data.sender_id)
            current_user = document.getElementById('user-id')
            current_user_id = current_user.dataset.userId
            console.log(data.sender_id)
            console.log(current_user_id)
            if Number(current_user_id) != Number(data.sender_id)
              el = document.createElement('div');
              el.insertAdjacentHTML('beforeend', data.html);

              el.querySelector(".message").classList.remove("me")
              el.querySelector(".delete-form").remove()
              messageContainer.innerHTML = messageContainer.innerHTML + el.innerHTML
            else
              messageContainer.innerHTML = messageContainer.innerHTML + data.html

          messageContainer.scrollTo(0, messageContainer.scrollHeight)

document.addEventListener 'turbolinks:load', load

