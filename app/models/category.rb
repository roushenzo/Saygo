class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :translit_name, :use => :slugged

  has_many :pages
  validates :name, :presence => true
  scope :for_main_menu, where(:show_in_the_main_menu => true)
  scope :for_search_bar, where(:show_in_the_search_bar => true)

  private
  def translit_name
    Russian.translit(name || '')
  end
end
