class Category < ActiveRecord::Base
  has_many :pages
  validates :name, :presence => true
end
