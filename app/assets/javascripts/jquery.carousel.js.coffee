(($) ->
  $.fn.carousel = (n=5) ->
      el = @
      lis = el.find('li')
      if lis.length > n
          $(lis[i]).hide() for i in [n...lis.length]
          $('.slider-right').live 'click', ->
            if lis.length > n
              $(el).find('li:hidden:first').show()
              $(el).find('li:visible:first').hide()
          $('.slider-left').live 'click', ->
            if lis.length > n
              $(el).find('li:hidden:last').show()
              $(el).find('li:visible:last').hide()
)(jQuery)