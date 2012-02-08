class AddIconFieldToCustomFields < ActiveRecord::Migration
  def change
    add_column :custom_fields, :icon, :string
  end
end
