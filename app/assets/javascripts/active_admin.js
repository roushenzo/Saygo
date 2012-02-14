//= require active_admin/base
//= require cities
$(document).ready(function() {
    var customFieldsOptions;
    $('select[name*="category_id"]').live('change', function() {
      if ($(this).val() === '') {
        $('select[name*="custom_field_id"]').html("<option> </option>");
      } else {
        $.get("/categories/" + ($(this).val()) + "/custom_fields", {}, function(data) {
          $('select[name*="custom_field_id"]').html(data);
          customFieldsOptions = data;
        });
      }
    });

    $('.page_custom_fields a.button:last').live('click', function() {
      var fieldSet = $(this).prev('fieldset');
      fieldSet.find('select[name*="custom_field_id"]').html(customFieldsOptions);
      fieldSet.find('label[for*="fields_attributes"]:parent').hide();
      fieldSet.find('label[for*="fields_attributes"] :input').attr('disabled', true);
      fieldSet.find('select[name*="custom_field_id"]').change(function() {
        var fieldSetInner = $(this).closest('fieldset');
        fieldSetInner.find('label[for*="fields_attributes"]:parent').hide();
        fieldSetInner.find('label[for*="fields_attributes"] input').attr('disabled', true);
        if ($(this).val() === '') {
          return fieldSetInner.find('select[name*="custom_field_id"]').html("<option></option>");
        } else{
          $.get("/custom_fields/" + ($(this).val()) + "/values.json", {}, function(data) {
            data.forEach(function(item){
              fieldSetInner.find('label[for$="value_ids_'+item+'"]:parent').show();
              $('label[for$="value_ids_'+item+'"] :input').removeAttr('disabled');
            });
          });
        }
      });
    });
});
