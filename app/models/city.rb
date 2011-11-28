class City < ActiveRecord::Base
  belongs_to :country
  validates :name, :presence => true
  validates_uniqueness_of :name, :scope => :country_id
end
