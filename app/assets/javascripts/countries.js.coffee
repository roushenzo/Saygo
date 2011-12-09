$(document).ready ->
  $('.search-button li a').live 'click', ->
    $('.search-button li a').removeClass('active')
    $(@).closest('ul').find('input:hidden').attr('disabled', true)
    $(@).addClass('active')
    $(@).closest('li').find('input:hidden').removeAttr('disabled')
