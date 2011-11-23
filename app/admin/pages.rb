ActiveAdmin.register Page do
  index do
    column :id
    column :title
    column :url
    column :country
    column :city
    column :category
    column :created_at
    column :updated_at
    column I18n.t('active_admin.content')  do |page|
       link_to(I18n.t('active_admin.edit'), '/editor' + page_path(page), :class => "member_link edit_link")
    end
    default_actions
  end

  form do |f|
    f.inputs "General info" do
      f.input :url, :as => :url
      f.input :title
      f.input :country, :as => :string
      f.input :city
      f.input :category, :as => :select
    end

    f.inputs :meta_title, :meta_keys, :meta_description, :name => "Meta tags"

    f.has_many :photos do |fi|
      fi.input :file_cache, :as => :hidden
      fi.input :file, :as => :file
      fi.input :remote_file_url, :as => :url
    end

    f.buttons
  end
end
