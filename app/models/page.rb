class Page < ActiveRecord::Base
  has_many :photos
  belongs_to :category
  belongs_to :country
  belongs_to :city
  accepts_nested_attributes_for :photos
  validates :url, :title, :presence => true
  validates :country, :associated => true, :if => Proc.new {|p| p.city.present?}
  validates :city, :associated => true, :if => Proc.new {|p| p.category.present?}
end
