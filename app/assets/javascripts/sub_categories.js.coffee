$(document).ready ->
  $('select[name*="[category_id]"]').live 'change', ->
    c = $(this).val()
    if c is ''
      $('select[name*="[sub_category_id]"]').html("<option>Выберите подкатегорию</option>")
    else
      params = if window.location.pathname.indexOf('/admin') is 0 then {param_as_id : true} else {}
      $.get "/categories/#{$(this).val()}/sub_categories", params, (data) ->
        $('select[name*="sub_category_id"]').html(data)
