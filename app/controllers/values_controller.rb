class ValuesController < InheritedResources::Base
  layout nil
  belongs_to :custom_field
  actions :index
  respond_to :json
end
