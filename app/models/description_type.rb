class DescriptionType < ActiveRecord::Base
  has_many :pages
  extend FriendlyId
  friendly_id :translit_name, :use => :slugged

  private
  def translit_name
    Russian.translit(name || '')
  end
end
