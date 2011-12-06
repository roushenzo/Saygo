ActiveAdmin.register Category do
  form do |f|
    f.inputs do
      f.input :name
      f.input :show_in_the_main_menu
      f.input :show_in_the_search_bar
    end
    f.buttons
  end
end
