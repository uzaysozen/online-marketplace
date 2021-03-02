channelName = 'MessagesChannel'
App.rooms.push {
  name: channelName,
  app: App.cable.subscriptions.create channelName,
    received: (data) ->
      console.log(data)
}