require 'spec_helper'

describe CustomFieldsController do

   before(:each) {
    @category_custom_field = Fabricate :category_custom_field
    @expected =  [@category_custom_field.custom_field_id].to_json


  }
  it {
    get 'index', :format => 'json', :category_id => @category_custom_field.category_id
    response.body.to_json.should eq(@expected)
  }

end
