$ ->
  $(document).on 'ajax-modal-show', ->
    $('select.select2').select2()
    $('.rating').rating()