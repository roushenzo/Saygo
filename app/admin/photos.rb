ActiveAdmin.register Photo do
  index do
    column :id
    column :file  do |photo|
      image_tag photo.file.url(:thumb)
    end
    column :page
    column :created_at
    column :updated_at
    default_actions
  end

  show do
    panel(I18n.t('active_admin.details', :model => active_admin_config.resource_name)) do
      attributes_table_for photo do
        rows :id, :page
        row(:image) { image_tag(photo.file.url(:thumb)) }
        rows :created_at, :updated_at
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :page
      f.input :file, :as => :file
      f.input :file_cache, :as => :hidden
      f.input :remote_file_url, :as => :url
    end
    f.buttons
  end
end
