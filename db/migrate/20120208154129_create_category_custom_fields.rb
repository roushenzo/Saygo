class CreateCategoryCustomFields < ActiveRecord::Migration
  def change
    create_table :category_custom_fields do |t|
      t.integer :category_id
      t.integer :custom_field_id

      t.timestamps
    end
  end
end
