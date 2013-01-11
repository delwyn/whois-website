$ ->
  $('#queryForm').submit ->
    $('button,input', @).attr('disabled', true)
    false
