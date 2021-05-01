$ ->
  $(document).on 'shown.bs.modal', ->
    $('#swap-form').submit ->
      $('#modalWindow').modal('hide');