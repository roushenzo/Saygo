class AddSlugToTables < ActiveRecord::Migration
  def change
    add_column :countries, :slug, :string
    add_column :cities, :slug, :string
    add_column :categories, :slug, :string
  end
end
