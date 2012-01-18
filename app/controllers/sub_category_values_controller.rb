class SubCategoryValuesController < InheritedResources::Base
  defaults(:collection_name => :values)
  layout nil
  belongs_to :sub_category
  actions :index
end
