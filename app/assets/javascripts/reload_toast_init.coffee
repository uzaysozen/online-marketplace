$ ->
  $(document).on 'ready', ->
    $('.toast').each( (_) ->
      $(this).toast('show');
    )