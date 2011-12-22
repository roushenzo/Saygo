$(document).ready ->
  $('select[name*="country_id"]').live 'change', ->
    c = $(this).val()
    if c is ''
      $('select[name*="city_id"]').html("<option>Выберите город</option>")
    else
      params = if window.location.pathname.indexOf('/admin') is 0 then {param_as_id : true} else {}
      $.get "/countries/#{$(this).val()}/cities", params, (data) ->
        $('select[name*="city_id"]').html(data)
