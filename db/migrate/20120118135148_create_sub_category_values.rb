class CreateSubCategoryValues < ActiveRecord::Migration
  def change
    create_table :sub_category_values do |t|
      t.string :name
      t.integer :sub_category_id

      t.timestamps
    end
  end
end
