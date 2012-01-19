ActiveAdmin.register DescriptionType do
  form do |f|
    f.inputs do
      f.input :category
      f.input :name
    end
    f.buttons
  end
end
