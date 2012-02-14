$(document).ready ->
  customFieldsOptions = null

  $('select[name*="category_id"]').live 'change', ->
    if $(this).val() is ''
      $('select[name*="custom_field_id"]').html("<option></option>")
    else
      $.get "/categories/#{$(this).val()}/custom_fields", {}, (data) ->
        $('select[name*="custom_field_id"]').html(data)
        customFieldsOptions = data

  $('.page_custom_fields a.button:last').live 'click', ->
    fieldSet = $(this).prev('fieldset')
    fieldSet.find('select[name*="custom_field_id"]').html(customFieldsOptions)
    fieldSet.find('label[for*="fields_attributes"]:parent').hide()
    fieldSet.find('label[for*="fields_attributes"] :checkbox').attr('disabled', true)
    fieldSet.find('select[name*="custom_field_id"]').change ->
      fieldSetInner = $(this).closest('fieldset')
      fieldSetInner.find('label[for*="fields_attributes"]:parent').hide()
      fieldSetInner.find('label[for*="fields_attributes"] :checkbox').attr('disabled', true)
      if $(this).val() is ''
        fieldSetInner.find('select[name*="custom_field_id"]').html("<option></option>")
      else
        $.get "/custom_fields/#{$(this).val()}/values.json", {}, (data) ->
          data.forEach (item) ->
            fieldSetInner.find("label[for$='value_ids_#{item}']:parent").show()
            fieldSetInner.find("label[for$='value_ids_#{item}'] :checkbox").removeAttr('disabled')
