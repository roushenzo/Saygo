class CustomFieldValue < ActiveRecord::Base
  belongs_to :custom_field
  validate :name, :presence => true
end
