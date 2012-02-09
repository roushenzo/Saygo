class AddPageCustomFieldIdToCustomFieldValues < ActiveRecord::Migration
  def change
    add_column :custom_field_values, :page_custom_field_id, :integer
  end
end
