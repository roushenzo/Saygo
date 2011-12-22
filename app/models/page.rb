class Page < ActiveRecord::Base
  paginates_per 20
  acts_as_commentable
  extend FriendlyId
  friendly_id :translit_title, :use => :slugged

  has_many :photos
  belongs_to :category
  belongs_to :country
  belongs_to :city
  belongs_to :description_type
  accepts_nested_attributes_for :photos
  validates :country_id, :presence => true
  validates :city_id, :presence => true, :if => proc {|p| p.category.present? }
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
    %w(category description_type country city).each do |item|
      if (param = params["#{item}_id".to_sym]).present?
        instance = item.classify.constantize.find(param)
        self.send("#{item}=", instance)
        search_query << pages["#{item}_id"].eq(instance.id)
      end
    end
    search_query << pages[:slug].eq(params[:id]) if params[:id].present?
    search_query << pages[:title].matches("%#{title}%")
    search_query.inject(Page.scoped) { |res, arel_query| res.where(arel_query) }.page(params[:page])
  end

  def self.search(params)
    self.new.search(params)
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

  def url
    {:controller => 'pages',
     :action => 'show',
     :id => slug,
     :country_id => country.try(:slug),
     :city_id => city.try(:slug),
     :category_id => category.try(:slug),
     :description_type_id => description_type.try(:slug)}
  end

  def countent_without_images
    content.gsub(/<img\b[^>]*(\/?)>/, '')
  end

  def description_types
    if country?
      country.description_types
    elsif city? || category?
      city.description_types
    else
      []
    end
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
