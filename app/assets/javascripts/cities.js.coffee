$(document).ready ->
  $('select[name*="country_id"]').live 'change', ->
    c = $(this).val()
    if c is ''
      $('select[name*="city_id"]').html("<option>Выберите город</option>")
    else
      $.get "/countries/#{$(this).val()}/cities", (data) ->
        $('select[name*="city_id"]').html(data)
