class CreateDescriptionTypes < ActiveRecord::Migration
  def up
    create_table :description_types do |t|
      t.string :name
      t.string :slug
      t.timestamps
    end
    add_column :pages, :description_type_id, :integer
    remove_column :categories, :show_in_the_main_menu
  end

  def down
    drop_table :description_types
    remove_column :pages, :description_type_id
    add_column :categories, :show_in_the_main_menu, :boolean, :default => false
  end
end
