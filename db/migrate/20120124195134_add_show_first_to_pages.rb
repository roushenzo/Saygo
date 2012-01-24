class AddShowFirstToPages < ActiveRecord::Migration
  def change
    add_column :pages, :show_first, :boolean, :default => false
  end
end
