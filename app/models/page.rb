class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :translit_title, :use => :slugged

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

  def content
    read_attribute(:content).present? ? read_attribute(:content) : default_value_for_content
  end

  private
  def default_value_for_content
    %Q{
      <div class="clear img-bottom">\n
        <img src="/assets/blank.jpg" class="img-indent"></img>\n
          Писать текст сюда, а слева - рисунок. Достаточно просто перетащить его с рабочего стола ужерживаю клавишу SHIFT.\n
          Текущий рисунок можно удалить\n
      </div>Описание<p class="indent-top-bottom">Описание</p>Описание\n
    }
  end

  def reset_sights_of_the_day
    self.class.update_all "sight_of_the_day = 0", ["id <> ? AND sight_of_the_day = 1", self.id]
  end

  def translit_title
    Russian.translit(title || '')
  end
end
