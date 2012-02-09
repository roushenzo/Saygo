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
