class CreateIndexes < ActiveRecord::Migration
  def change
    [:country_id, :city_id, :category_id, :sub_category_id, :description_type_id, :show_menu, :show_in_menu, :active].each do |i|
      add_index :pages, i
    end
    add_index :photos, :page_id
    add_index :sub_categories, :category_id
    add_index :sub_category_values, :sub_category_id
    add_index :info_blocks, :page_id
    add_index :description_types, :slug
    add_index :description_types, :category_id
    add_index :countries, :slug
    add_index :cities, :slug
    add_index :categories, :slug
    add_index :categories, :show_in_the_search_bar
    add_index :categories, :description_type_id
  end
end
