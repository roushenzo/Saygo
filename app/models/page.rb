# -*- encoding : utf-8 -*-
class Page < ActiveRecord::Base
  default_scope where(:active => true).order('show_first DESC, created_at DESC')
  paginates_per 20
  acts_as_commentable
  extend FriendlyId
  friendly_id :translit_title, :use => :slugged

  has_many :page_custom_fields
  has_many :custom_fields, :through => :page_custom_fields
  accepts_nested_attributes_for :page_custom_fields

  has_many :comments
  has_many :photos, :dependent => :destroy
  belongs_to :category
  belongs_to :country
  belongs_to :city
  belongs_to :description_type
  accepts_nested_attributes_for :photos
  validates :country_id, :presence => true
  validates :city_id, :presence => true, :if => :category_id
  validates :title, :presence => true
  validates_uniqueness_of :title, :scope => [:country_id, :city_id, :category_id, :description_type_id]
  validates :shop_template, :inclusion => {:in => [false], :unless => :category?,
                                           :message => 'It is impossible to apply shop template for description page'}
  after_save :reset_boolean_fields
  attr_accessor :order_by
  scope :inactive, where(:active => false)
  scope :for_top, where(:show_in_top => true).limit(10)
  delegate :name, :to => :country, :prefix => true, :allow_nil => true

  def self.current_sight_of_the_day
    where(:sight_of_the_day => true).last || last
  end

  def average_rate
    return 0 if comments.count == 0
    (comments.sum(:rate)/comments.count.to_f).ceil
  end

  def content
    read_attribute(:content).present? ? read_attribute(:content) : default_value_for_content
  end

  def featured_image_file
    photos.first.try(:file) || photos.new.file
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

  def single_custom_fields
    page_custom_fields.select {|f| f.values.count == 1 }
  end

  def multiple_custom_fields
    page_custom_fields.select {|f| f.values.count > 1 }
  end

  private
  def reset_show_in_top
    ps = self.class.where(:show_in_top => true,
                          :description_type_id => description_type_id || category.try(:description_type_id),
                          :city_id => city_id,
                          :country_id => country_id)
    if ps.count > 10
      (11..ps.count).each do |i|
        ps[i-11].update_attribute(:show_in_top, false) if ps[i-11].id != id
      end
    end
  end

  def reset_sigt_of_the_day
    self.class.update_all "sight_of_the_day = 0", ["id <> ? AND sight_of_the_day = 1", self.id]
  end

  def default_image_tag
    %Q{<img src="/assets/blank.jpg" class="img-indent"></img>}
  end

  def default_value_for_content
    %Q{
      <div class="clear img-bottom">\n
        #{default_image_tag}\n
          Drag image from desctop to replace default image. Description text write here.
      </div><p class="indent-top-bottom">Content</p>
    }
  end

  def reset_show_first
    self.class.unscoped.update_all ["show_first = ?", false],
      ["country_id = :country_id AND city_id = :city_id AND id NOT in (:id)",
        {:city_id => city_id, :country_id => country_id, :show_first => true, :id => id}]
  end

  def reset_all_boolean_flags
    self.update_column(:show_in_top, false)
    self.update_column(:sight_of_the_day, false)
    self.update_column(:show_first, false)
  end

  def set_show_in_menu
    self.update_column(:show_in_menu, true)
  end

  def reset_boolean_fields
    reset_show_in_top if show_in_top_changed? && show_in_top?
    reset_sigt_of_the_day if sight_of_the_day? && sight_of_the_day_changed?
    reset_show_first if show_first_changed? && show_first?
    reset_all_boolean_flags if active_changed? && !active?
    set_show_in_menu if show_menu_changed? && show_menu?
  end

  def translit_title
    Russian.translit(title || '')
  end
end
