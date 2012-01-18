ActiveAdmin.register SubCategory do
  menu :parent => 'Categories'
  form do |f|
    f.inputs "General fields" do
      f.input :category, :as => :select
      f.input :name
    end
    f.inputs 'Values' do
      f.has_many :values do |fv|
        fv.input :name
      end
    end
    f.buttons
  end
end
