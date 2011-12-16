SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'
  navigation.items do |primary|
    primary.item :countries, 'Страны', root_path, :highlight_on => //
    if @page
        primary.item :cities, 'Города', page_path(@country) if @country
        @page.description_types.each do |t|
          primary.item "categoty-#{t.slug}", t.name,
                          page_path(:country_id => @country.try(:slug), :city_id => @city.try(:slug), :description_type_id => t.slug)
        end
      end
    primary.item :search, 'Поиск', search_path
    primary.dom_class = 'top-menu list0'
  end
end
