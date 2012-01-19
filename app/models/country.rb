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

  def self.for_frontend
    country_pages_ids = Page.where(:city_id => nil).select(:country_id).map(&:country_id).uniq
    self.where(:id => country_pages_ids)
  end

  private
  def translit_name
    Russian.translit(name || '')
  end
end
