class SubCategory < ActiveRecord::Base
  validates :category_id, :name, :presence => true
  belongs_to :category
  has_many :values, :class_name => 'SubCategoryValue'
  accepts_nested_attributes_for :values
end
