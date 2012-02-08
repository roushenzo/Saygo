class CustomField < ActiveRecord::Base
  has_many :category_custom_fields
  has_many :categories, :through => :category_custom_fields
  has_many :values, :class_name => 'CustomFieldValue', :dependent => :destroy
  accepts_nested_attributes_for :values
  validates :name, :presence => true, :uniqueness => true
  mount_uploader :icon, IconUploader
end
