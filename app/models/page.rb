class Page < ActiveRecord::Base
  has_many :photos
  belongs_to :category
  belongs_to :country
  belongs_to :city
  accepts_nested_attributes_for :photos
  validates :url, :title, :presence => true
  validates :country, :associated => true, :if => Proc.new {|p| p.city.present?}
  validates :city, :associated => true, :if => Proc.new {|p| p.category.present?}
  validates_uniqueness_of :title, :scope => [:country_id, :city_id, :category_id]
  after_save :reset_sights_of_the_day, :if => "sight_of_the_day? && sight_of_the_day_changed?"

  def self.current_sight_of_the_day
    where(:sight_of_the_day => true).last || first
  end

  private
  def reset_sights_of_the_day
    self.class.update_all "sight_of_the_day = 0", ["id <> ? AND sight_of_the_day = 1", self.id]
  end
end
