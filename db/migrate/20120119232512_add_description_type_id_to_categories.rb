class AddDescriptionTypeIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :description_type_id, :integer
  end
end
