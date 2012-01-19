class DescriptionType < ActiveRecord::Base
  has_many :pages
  extend FriendlyId
  friendly_id :translit_name, :use => :slugged
  validates :name, :category_id, :presence => true

  private
  def translit_name
    Russian.translit(name || '')
  end
end
