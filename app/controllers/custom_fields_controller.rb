class CustomFieldsController < InheritedResources::Base
  layout nil
  belongs_to :category
  actions :index

end
