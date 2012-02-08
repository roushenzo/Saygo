class CustomField < ActiveRecord::Base
  has_many :category_custom_fields
  has_many :categories, :through => :category_custom_fields
  validates :name, :presence => true, :uniqueness => true
  mount_uploader :icon, IconUploader
end
