# Set theme for our select2 elements
$.fn.select2.defaults.set("theme", "bootstrap")

$ ->
  $(document).on 'ready turbolinks:load ajax-modal-shown', ->
    $('.select2-tags').each( (_) ->
      $(this).select2({closeOnSelect: false, tags: true, tokenSeparators: [',', ' '], dropdownCssClass: 'd-none'})
    )

    $('.select2-multiple').each( (_) ->
      $(this).select2({closeOnSelect: false})
    )