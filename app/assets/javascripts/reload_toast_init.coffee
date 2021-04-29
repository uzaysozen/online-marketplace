$ ->
  $(document).on 'ready turbolinks:load', ->
    # On page load we need to manually show each of the toasts.
    $('.toast').each( (_) ->
      $(this).toast('show');
    )