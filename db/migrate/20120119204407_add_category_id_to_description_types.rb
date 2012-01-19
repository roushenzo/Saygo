class AddCategoryIdToDescriptionTypes < ActiveRecord::Migration
  def change
    add_column :description_types, :category_id, :integer
  end
end
