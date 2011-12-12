$(document).ready ->
  $('select[name*="country_id"]').live 'change', ->
    $.get "/countries/#{$(this).val()}/cities", (data) ->
      $('select[name*="city_id"]').html(data);
