ActiveAdmin.register Page do
  scope :inactive
  scope :all

  show do
    attributes_table :title, :country, :city, :category, :description_type, :sight_of_the_day,
      :show_in_top, :show_first, :show_menu, :show_in_menu, :meta_title, :meta_keys, :meta_description, :created_at, :updated_at
    active_admin_comments
  end

  filter :country
  filter :city
  filter :category
  filter :description_type
  filter :title
  filter :sight_of_the_day, :as => :select
  filter :active, :as => :select
  filter :show_in_top, :as => :select
  filter :created_at
  filter :updated_at

  index do
    column :id
    column :title
    column :country
    column :city
    column :category
    column :description_type
    column :created_at
    column :updated_at
    column I18n.t('active_admin.content')  do |page|
       link_to(I18n.t('active_admin.edit'), '/editor' + page_path(page.country, page.city, page.category, page.slug), :class => "member_link edit_link")
    end
    default_actions
  end

  form do |f|
    f.inputs "General info" do
      f.input :title
      f.input :show_all_button_text
      f.input :country, :as => :select
      f.input :city, :as => :select
      f.input :description_type
      f.input :category, :as => :select
    end

    f.inputs 'Custom fields' do
      f.has_many :page_custom_fields do |cf|
        cf.input :custom_field, :as => :select
        cf.input :values, :as => :check_boxes
        cf.semantic_fields_for cf.object.values.new do |cfv|
          cfv.input :name
        end
        cf.input :_destroy, :as => :boolean, :label => 'Remove', :hint => "Deletes this custom field. You should press 'Update|Craete page button' to get effect"
      end
    end

    f.inputs 'Boolean flags' do
      f.input :active, :hint => 'Check this field if you want to hide this page. Users wont see this page at all'
      f.input :sight_of_the_day, :hint => 'Show this page on the mane page - it is the featured page'
      f.input :show_in_top, :hint => 'Check if you want to show this object on top 10 block'
      f.input :show_first, :hint => 'If page is a desription page, this page will be showd first, e.g. when if click on the country or city link'
      f.input :show_menu, :hint => 'Show side bar on this page instead of top block'
      f.input :show_in_menu, :label => 'Show in side menu', :hint => 'Check this field if you want to show in the side bar'
      f.input :shop_template, :hint => 'Check this button if you want to make design for this page as for shop'
    end

    f.inputs :meta_title, :meta_keys, :meta_description, :name => "Meta tags"

    f.inputs 'Photos' do
      f.has_many :photos do |fi|
        fi.input :file_cache, :as => :hidden
        fi.input :file, :as => :file
        fi.input :remote_file_url, :as => :url
        fi.input :remove_file, :as => :boolean, :hint => fi.object.persisted? ? fi.template.image_tag(fi.object.file.url(:thumb)) : ''
      end
    end

    f.buttons
  end

  member_action :mercury_update, :method => :put do
    @page = Page.find(params[:id])
    @page.content = params[:content][:page_content][:value]
    @page.save!
    flash[:notice] = 'Page was updated successfully.'
    render :text => ''
  end

  controller do
    def resource
      @page ||= active_admin_config.resource.unscoped.find(params[:id])
    end

    def scoped_collection
      end_of_association_chain.unscoped
    end
  end
end
