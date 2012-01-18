class SubCategoryValue < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :sub_category
end
