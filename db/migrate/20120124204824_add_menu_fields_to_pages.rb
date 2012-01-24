class AddMenuFieldsToPages < ActiveRecord::Migration
  def change
    add_column :pages, :show_menu, :boolean, :default => false
    add_column :pages, :show_in_menu, :boolean, :default => false
  end
end
