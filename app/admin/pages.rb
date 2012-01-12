ActiveAdmin.register Page do
  show do
    attributes_table :title, :country, :city, :category, :description_type, :meta_title, :meta_keys, :meta_description, :created_at, :updated_at
    active_admin_comments
  end

  filter :country
  filter :city
  filter :category
  filter :description_type
  filter :title
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
      f.input :category, :as => :select
    end

    f.inputs 'Boolean flags' do
      f.input :sight_of_the_day
      f.input :description_type
    end

    f.inputs :meta_title, :meta_keys, :meta_description, :name => "Meta tags"
    f.inputs do
      f.has_many :info_blocks do |fb|
        fb.input :title
        fb.input :content
      end
    end

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
end
