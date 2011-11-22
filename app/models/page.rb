class Page < ActiveRecord::Base
  has_many :images
  belongs_to :category
  accepts_nested_attributes_for :images
  validates :url, :title, :presence => true
  validates :country, :presence => true, :if => Proc.new {|p| p.city.present?}
  validates :city, :presence => true, :if => Proc.new {|p| p.category.present?}
end
