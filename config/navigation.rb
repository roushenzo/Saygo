SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'
  navigation.items do |primary|
    primary.item :countries, 'Страны', root_path, :highlight_on => //
    if @page
      primary.item :cities, 'Города', page_path(@country)
      @page.description_types.each do |t|
        primary.item "categoty-#{t.slug}", t.name, page_path(@country, @city, :description_type_id => t.slug)
      end
    end
    primary.dom_class = 'top-menu list0'
  end
end
