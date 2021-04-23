$ ->
  $(document).on 'ready turbolinks:load ajax:success', ->
    $('form.remove').each( (_) ->
      $(this).submit ->
        $(this).closest('tr').remove();
    )    