$(document).ready ->
  $('#carousel').carousel()
  $('#carousel2').carousel(3)
  $('.fancybox-menium-image').hide()
  $('.fancybox-menium-image:first').show()
  $('.fancybox-inline').live 'click', ->
    $('.fancybox-menium-image').fadeOut()
    $($(this).attr('href')).fadeIn()
    return false
  $('.fancybox').fancybox({cyclic : true, scrolling : 'yes'})
  $("#stars-wrapper").stars({inputType: "select"})
  $('.page-rate').stars({inputType: 'select', disabled: true}) #init static stars rate for page
  $('.notification').notify();
