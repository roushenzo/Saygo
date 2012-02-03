ActiveAdmin.register DescriptionType do
  form do |f|
    f.inputs do
      f.input :name
      f.input :categories, :as => :check_boxes
    end
    f.buttons
  end
end
