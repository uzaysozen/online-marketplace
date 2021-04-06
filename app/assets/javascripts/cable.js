// app/assets/javascripts/cable.js
//= require action_cable
//= require_self
//= require_tree ./channels

(function() {
    this.App || (this.App = {});
    this.App.rooms || (this.App.rooms = []);
    App.cable = ActionCable.createConsumer();
}).call(this);