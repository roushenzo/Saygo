ActiveAdmin.register DescriptionType do
  menu :parent => 'Categories'
  form do |f|
    f.inputs do
      f.input :category
      f.input :name
    end
    f.buttons
  end
end
