class AddShowTypeToCustomFields < ActiveRecord::Migration
  def change
    add_column :custom_fields, :show_type, :integer
  end
end
