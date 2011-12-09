class Category < ActiveRecord::Base
  has_many :pages
  validates :name, :presence => true
  scope :for_main_menu, where(:show_in_the_main_menu => true)
end
