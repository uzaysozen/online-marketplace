# Set theme for our select2 elements
$.fn.select2.defaults.set("theme", "bootstrap")

$ ->
  $(document).on 'ready turbolinks:load', ->
    $('.select2').each( (_) ->
      # Initialise our select2 elements on page load, currently only for tags.
      $(this).select2({closeOnSelect: false, tags: true, tokenSeparators: [',', ' ']}, )
    )