class AddNewIndexes < ActiveRecord::Migration
  def up
    add_index :category_custom_fields, :category_id
    add_index :category_custom_fields, :custom_field_id
    add_index :comments, :page_id
    add_index :custom_field_values, :custom_field_id
    add_index :custom_field_values, :page_custom_field_id
    add_index :page_custom_fields, :page_id
    add_index :page_custom_fields, :custom_field_id
    add_index :pages, :shop_template
  end

  def down
    remove_index :category_custom_fields, :category_id
    remove_index :category_custom_fields, :custom_field_id
    remove_index :comments, :page_id
    remove_index :custom_field_values, :custom_field_id
    remove_index :custom_field_values, :page_custom_field_id
    remove_index :page_custom_fields, :page_id
    remove_index :page_custom_fields, :custom_field_id
    remove_index :pages, :shop_template
  end
end
