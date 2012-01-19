class AddShowInTopToPages < ActiveRecord::Migration
  def change
    add_column :pages, :show_in_top, :boolean, :default => false
  end
end
