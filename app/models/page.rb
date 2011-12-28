class Page < ActiveRecord::Base
  paginates_per 20
  acts_as_commentable
  extend FriendlyId
  friendly_id :translit_title, :use => :slugged

  has_many :photos
  has_many :info_blocks
  belongs_to :category
  belongs_to :country
  belongs_to :city
  belongs_to :description_type
  accepts_nested_attributes_for :photos
  accepts_nested_attributes_for :info_blocks
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
      elsif params[:force]
        search_query << pages["#{item}_id"].eq(nil) if item != 'description_type'
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
          \320\237\320\270\321\201\320\260\321\202\321\214 \321\202\320\265\320\272\321\201\321\202 \321\201\321\216\320\264\320\260, \320\260 \321\201\320\273\320\265\320\262\320\260 - \321\200\320\270\321\201\321\203\320\275\320\276\320\272. \320\224\320\276\321\201\321\202\320\260\321\202\320\276\321\207\320\275\320\276 \320\277\321\200\320\276\321\201\321\202\320\276 \320\277\320\265\321\200\320\265\321\202\320\260\321\211\320\270\321\202\321\214 \320\265\320\263\320\276 \321\201 \321\200\320\260\320\261\320\276\321\207\320\265\320\263\320\276 \321\201\321\202\320\276\320\273\320\260.\n
          \320\242\320\265\320\272\321\203\321\211\320\270\320\271 \321\200\320\270\321\201\321\203\320\275\320\276\320\272 \320\274\320\276\320\266\320\275\320\276 \321\203\320\264\320\260\320\273\320\270\321\202\321\214\n
      </div><p class="indent-top-bottom">\320\236\320\277\320\270\321\201\320\260\320\275\320\270\320\265</p>
    }
  end

  def reset_sights_of_the_day
    self.class.update_all "sight_of_the_day = 0", ["id <> ? AND sight_of_the_day = 1", self.id]
  end

  def translit_title
    Russian.translit(title || '')
  end
end
