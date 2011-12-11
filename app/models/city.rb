class City < ActiveRecord::Base
  extend FriendlyId
  friendly_id :translit_name, :use => :slugged

  belongs_to :country
  validates :name, :presence => true
  validates_uniqueness_of :name, :scope => :country_id

  private
  def translit_name
    Russian.translit(name || '')
  end
end
