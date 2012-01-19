class DescriptionType < ActiveRecord::Base
  has_many :pages
  has_many :categories
  extend FriendlyId
  friendly_id :translit_name, :use => :slugged
  validates :name, :presence => true

  private
  def translit_name
    Russian.translit(name || '')
  end
end
