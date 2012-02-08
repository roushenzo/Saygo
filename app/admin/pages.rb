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

    f.inputs 'Boolean flags' do
      f.input :active
      f.input :sight_of_the_day
      f.input :show_in_top
      f.input :show_first
      f.input :show_menu
      f.input :show_in_menu, :label => 'Show in side menu'
    end

    f.inputs :meta_title, :meta_keys, :meta_description, :name => "Meta tags"

    f.inputs do
      f.has_many :photos do |fi|
        fi.input :file_cache, :as => :hidden
        fi.input :file, :as => :file
        fi.input :remote_file_url, :as => :url
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
