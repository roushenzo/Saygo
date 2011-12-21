class Country < ActiveRecord::Base
  extend FriendlyId
  friendly_id :translit_name, :use => :slugged

  default_scope order('name')
  has_many :pages, :conditions => {:city_id => nil, :category_id => nil}
  has_many :description_types, :through => :pages, :uniq => true
  has_many :categories, :through => :pages, :uniq => true
  has_many :cities
  validates :name, :presence => true, :uniqueness => true
  validates :flag, :presence => true
  mount_uploader :flag, FlagUploader

  private
  def translit_name
    Russian.translit(name || '')
  end
end
