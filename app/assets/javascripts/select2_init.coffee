$.fn.select2.defaults.set("theme", "bootstrap")

$ ->
  $(document).on 'ready turbolinks:load', ->
    $('.select2').each( (_) ->
      $(this).select2({closeOnSelect: false, tags: true, tokenSeparators: [',', ' ']}, )
    )