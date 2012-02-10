class DeleteTypeFromCustomFields < ActiveRecord::Migration
  def up
    remove_column :custom_fields, :type
  end

  def down
    add_column :custom_fields, :type, :string
  end
end
