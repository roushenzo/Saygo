ActiveAdmin.register Country do
  index do
    column :id
    column :name
    column :flag do |c|
      image_tag c.flag.url
    end
    column :created_at
    column :updated_at
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :flag_cache, :as => :hidden
      f.input :name
      f.input :flag, :as => :file
      f.input :remote_flag_url, :as => :url
    end
    f.buttons
  end
end
