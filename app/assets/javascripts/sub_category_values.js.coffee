$(document).ready ->
  $('select[name*="[sub_category_id]"]').live 'change', ->
    c = $(this).val()
    if c is ''
      $('select[name*="[sub_category_value_id]"]').html("<option>Выберите значение подкатегории</option>")
    else
      params = if window.location.pathname.indexOf('/admin') is 0 then {param_as_id : true} else {}
      $.get "/sub_categories/#{$(this).val()}/values", params, (data) ->
        $('select[name*="sub_category_value_id"]').html(data)
