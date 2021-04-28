// app/assets/javascripts/cable.js
//= require action_cable
//= require_self
//= require_tree ./channels

function getCookie(name) {
    const value = `; ${document.cookie}`;
    const parts = value.split(`; ${name}=`);
    if (parts.length === 2) return parts.pop().split(';').shift();
}

(function() {
    this.App || (this.App = {});
    this.App.rooms || (this.App.rooms = []);
    let token = getCookie('token')
    if (token) {
        App.cable = ActionCable.createConsumer(`/cable?token=${token}`);
    }
}).call(this);