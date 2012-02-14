//= require active_admin/base
//= require cities

$(document).ready(function() {


    var data1;
    $('select[name*="category_id"]').live('change', function() {
       // $('select[name*="custom_field_id"]').hide(5000);
        var c, params;
    c = $(this).val();
        if (c === '') {
            $('select[name*="custom_field_id"]').html("<option> </option>");
    } else {

       $.get("/categories/" + ($(this).val()) + "/custom_fields", params, function(data) {
         $('select[name*="custom_field_id"]').html(data);
         data1=data;
      });
    }

    });
   // $('select[name*="custom_field_id"]')
   $('a[onclick*="page_page_custom"]').live('click', function() {
       $('select[name*="custom_field_id"]').html(data1);
       $('label[for*="fields_attributes"]').parent.hide();
       $('label[for*="fields_attributes"] :input').attr('disabled', true);
       $('select[name*="custom_field_id"]').live('change', function() {
           $('label[for*="fields_attributes"]').parent.hide();
           $('label[for*="fields_attributes"] input').attr('disabled', true);
           var c, params;
           c = $(this).val();
           if (c === '') {
            return $('select[name*="custom_field_id"]').html("<option></option>");
           } else{
               $.get("/custom_fields/" + ($(this).val()) + "/values.json", params, function(data) {
                   data.forEach(function(item){
                       $('label[for$="value_ids_'+item+'"]').show();
                       $('label[for$="value_ids_'+item+'"] :input').removeAttr('disabled');
                   });
               });
           }
       });
   });


});
