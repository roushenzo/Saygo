class CitiesController < InheritedResources::Base
  layout nil
  belongs_to :country
  actions :index
end
