class PageCustomField < ActiveRecord::Base
  belongs_to :page
  belongs_to :custom_field
  has_many :values, :class_name => 'CustomFieldValue'
  accepts_nested_attributes_for :values
end
