class Page < ActiveRecord::Base
  has_many :images
  belongs_to :category
  accepts_nested_attributes_for :images
end
