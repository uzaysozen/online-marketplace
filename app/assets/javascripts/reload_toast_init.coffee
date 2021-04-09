$ ->
  $(document).on 'ready turbolinks:load', ->
    $('.toast').each( (_) ->
      $(this).toast('show');
    )