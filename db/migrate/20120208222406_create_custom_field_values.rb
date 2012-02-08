class CreateCustomFieldValues < ActiveRecord::Migration
  def change
    create_table :custom_field_values do |t|
      t.string :name
      t.integer :custom_field_id

      t.timestamps
    end
  end
end
