class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :content
      t.integer :category_id
      t.integer :country_id
      t.integer :city_id
      t.string :url
      t.string :meta_title
      t.text :meta_keys
      t.text :meta_description

      t.timestamps
    end
  end
end
