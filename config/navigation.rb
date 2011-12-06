SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'
  navigation.items do |primary|
    primary.item :countries, 'Страны', countries_path, :highlight_on => /(\/countries)|(\/)/
    primary.dom_class = 'top-menu list0'
  end
end
