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
    f.inputs do
      f.input :name
      f.input :categories, :as => :check_boxes
    end
    f.buttons
  end
end
