SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'
  navigation.items do |primary|
    primary.item :countries, 'Страны', root_path, :highlight_on => //
    Category.for_main_menu.each do |c|
      primary.item "category#{c.id}", c.name, search_path(:category_id => c.slug,
                                                          :country_id => @country.try(:slug),
                                                          :city_id => @city.try(:slug)), :highlight_on => /category/
    end
    primary.dom_class = 'top-menu list0'
  end
end
