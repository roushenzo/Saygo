(($) ->
  $.fn.carousel = (n=5) ->
      el = @
      lis = el.find('li')
      if lis.length > n
          $(lis[i]).hide() for i in [n...lis.length]
          $('.slider-right').live 'click', ->
            if lis.length > n
              if (next = $(el).find('li:visible:last').next()) && (next.length)
                $(el).find('li:visible:first').hide()
                next.show()
          $('.slider-left').live 'click', ->
            if lis.length > n
              if (prev = $(el).find('li:visible:first').prev()) && (prev.length)
                $(el).find('li:visible:last').hide()
                prev.show()
)(jQuery)
