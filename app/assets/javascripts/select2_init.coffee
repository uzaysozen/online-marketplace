$.fn.select2.defaults.set("theme", "bootstrap")

$ ->
  $(document).on 'ready turbolinks:load ajax-modal-shown', ->
    $('.select2').each( (_) ->
      $(this).select2({closeOnSelect: false, tags: true, tokenSeparators: [',', ' ']}, )
    )