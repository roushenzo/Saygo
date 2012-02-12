ActiveAdmin.register DescriptionType do
  form do |f|
    f.inputs do
      f.input :name
      f.input :link_weight, :as => :select, :collection => (1..100).to_a
      f.input :categories, :as => :check_boxes
    end
    f.buttons
  end
end
