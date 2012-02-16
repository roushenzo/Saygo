ActiveAdmin.register CustomField do
  menu :parent => 'Categories'
  show do
    attributes_table :name, :created_at, :updated_at
    panel 'Categories' do
      table_for custom_field.categories do
        column :name do |category|
          category.name
        end
      end
    end
    active_admin_comments
  end
  form do |f|
    f.inputs 'Main fields' do
      f.input :icon_cache, :as => :hidden
      if f.object.icon.present?
        f.input :name, :hint => f.template.image_tag(f.object.icon)
        f.input :remove_icon, :as => :boolean
      else
        f.input :name
      end
      f.input :icon, :as => :file
      f.input :remote_icon_url, :as => :url
      f.input :show_type, :as => :select , :collection => CustomField::TYPES, :prompt => false
      f.input :categories, :as => :check_boxes
    end
    f.inputs 'Values' do
      f.has_many :values do |fv|
        fv.input :name
        fv.input :_destroy, :as => :boolean, :label => 'Delete'
      end
    end
    f.buttons
  end
end
