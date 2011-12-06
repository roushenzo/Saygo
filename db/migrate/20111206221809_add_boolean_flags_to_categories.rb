class AddBooleanFlagsToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :show_in_the_search_bar, :boolean, :default => false
    add_column :categories, :show_in_the_main_menu, :boolean, :default => false
  end
end
