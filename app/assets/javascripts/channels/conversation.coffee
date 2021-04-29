load = ->
  # Ensure that we have an App instance
  if App.cable == undefined
    return

  conversation_element = document.getElementById('conversation-id')

  # If there's no conversation element, there's nothing to listen for.
  if conversation_element == null
    App.cable.disconnect()
    return

  # Extract the conversation ID from the data attribute
  conversation_id = conversation_element.getAttribute('data-conversation-id')

  # Make sure the conversation ID existed.
  if !conversation_id
    return;

  # Cleanup previous subscriptions
  for subscription in App.cable.subscriptions.subscriptions
    App.cable.subscriptions.remove(subscription)

  # Create a subscription to the conversation channel for this conversation
  App.room = App.cable.subscriptions.create {
    channel: 'ConversationChannel'
    conversation_id: conversation_id
  },
    received: (data) ->
      # If we were sent a message ID, we're deleting it.
      if data.message_id
        messageContent = document.getElementById('message-' + data.message_id)
        messageContent.remove()
      else if (data.sender_id)
        # Extract current user ID from document
        current_user = document.getElementById('user-id')
        current_user_id = current_user.dataset.userId

        # Get messages container to append message to.
        messageContainer = document.getElementById('messages')

        # If message was not sent by current user we need to remove the class and delete form
        # Otherwise we can just put it in as is.
        if Number(current_user_id) != Number(data.sender_id)
          el = document.createElement('div');
          el.insertAdjacentHTML('beforeend', data.html);

          el.querySelector(".message").classList.remove("me")
          el.querySelector(".delete-form").remove()
          messageContainer.innerHTML = messageContainer.innerHTML + el.innerHTML
        else
          messageContainer.innerHTML = messageContainer.innerHTML + data.html

        # Scroll to new messages.
        messageContainer.scrollTo(0, messageContainer.scrollHeight)

document.addEventListener 'turbolinks:load', load

