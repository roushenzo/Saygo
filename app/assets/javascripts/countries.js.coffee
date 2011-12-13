$(document).ready ->
  searchBar = (selector) ->
    $(selector).live 'click', ->
      $(selector).removeClass('active')
      $(@).closest('ul').find('input:hidden').attr('disabled', true)
      $(@).addClass('active')
      $(@).closest('li').find('input:hidden').removeAttr('disabled')

  searchBar('.search-button li a')
  searchBar('.box-search li a')
