$.fn.select2.defaults.set("theme", "bootstrap")

$ ->
  $(document).on 'init-select2', '.select2', ->
    $(this).select2({tags: true, tokenSeparators: [',', ' ']})
  
  $('.select2').trigger('init-select2')