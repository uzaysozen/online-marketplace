# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
     
window.notice = (content) -> 
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
