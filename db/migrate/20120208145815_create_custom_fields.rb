class CreateCustomFields < ActiveRecord::Migration
  def up
    create_table :custom_fields, :force => true do |t|
      t.string :type
      t.string :name
      t.timestamps
    end
    change_table :pages do |t|
      t.remove :sub_category_id
      t.remove :sub_category_value_id
    end
    drop_table :sub_categories
    drop_table :sub_category_values
  end

  def down
    create_table "sub_categories", :force => true do |t|
      t.string   "name"
      t.integer  "category_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    create_table "sub_category_values", :force => true do |t|
      t.string   "name"
      t.integer  "sub_category_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    change_table :pages do |t|
      t.integer :sub_category_id
      t.integer :sub_category_value_id
    end
    drop_table :custom_fields
  end
end
