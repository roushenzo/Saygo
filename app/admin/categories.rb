ActiveAdmin.register Category do

  show do
    attributes_table :name, :description_type, :show_in_the_search_bar, :created_at, :updated_at
    panel 'Custom fields' do
      table_for category.custom_fields do
        column :name do |cf|
          cf.name
        end
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description_type
      f.input :show_in_the_search_bar
      f.input :custom_fields, :as => :check_boxes
    end
    f.buttons
  end
end
