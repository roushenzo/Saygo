class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :description
      t.integer :category_id
      t.string :url
      t.string :meta_title
      t.string :country
      t.string :city
      t.text :meta_keys
      t.text :meta_description

      t.timestamps
    end
  end
end
