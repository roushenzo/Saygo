SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'
  navigation.items do |primary|
    primary.item :countries, I18n.t('.countries'), countries_path, :highlight_on => /(\/countries)|(\/)/
    primary.item :cities, I18n.t('.cities'), cities_path
    primary.item :categories, I18n.t('categories'), categories_path
    primary.dom_class = 'top-menu list0'
  end
end
