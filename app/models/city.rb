class City < ActiveRecord::Base
  extend FriendlyId
  friendly_id :translit_name, :use => :slugged
  has_many :pages
  has_many :description_types, :through => :pages, :uniq => true
  has_many :categories, :through => :pages, :uniq => true
  belongs_to :country
  validates :name, :presence => true
  validates_uniqueness_of :name, :scope => :country_id

  private
  def translit_name
    Russian.translit(name || '')
  end
end
