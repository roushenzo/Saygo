class Page < ActiveRecord::Base
  paginates_per 20
  extend FriendlyId
  friendly_id :translit_title, :use => :slugged

  has_many :photos
  belongs_to :category
  belongs_to :country
  belongs_to :city
  belongs_to :description_type
  accepts_nested_attributes_for :photos
  validates :country, :associated => true, :if => Proc.new {|p| p.city.present?}
  validates :city, :associated => true, :if => Proc.new {|p| p.category.present?}
  validates :title, :presence => true
  validates_uniqueness_of :title, :scope => [:country_id, :city_id, :category_id, :description_type_id]
  after_save :reset_sights_of_the_day, :if => "sight_of_the_day? && sight_of_the_day_changed?"
  attr_accessor :order_by

  def self.current_sight_of_the_day
    where(:sight_of_the_day => true).last || first
  end

  def content
    read_attribute(:content).present? ? read_attribute(:content) : default_value_for_content
  end

  def image_tag
    Nokogiri::HTML(content).css('img').first || default_image_tag
  end

  def search(params)
    pages = Page.arel_table
    search_query = []
    %w(category country city description_type).each do |item|
      if (param = params["#{item}_id".to_sym]).present?
        self.send("#{item}=", item.classify.constantize.find(param))if param.present?
        search_query << pages["#{item}_id"].eq(self.send("#{item}_id")) unless item == 'title'
      end
    end
    search_query << pages[:title].matches("%#{title}%")
    Page.where(*search_query).page(params[:page])
  end

  def category?
    country.present? && city.present? && category.present?
  end

  def city?
    country.present? && city.present? && !category.present?
  end

  def country?
    country.present? && !city.present? && !category.present?
  end

  private
  def default_image_tag
    %Q{<img src="/assets/blank.jpg" class="img-indent"></img>}
  end

  def default_value_for_content
    %Q{
      <div class="clear img-bottom">\n
        #{default_image_tag}\n
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
