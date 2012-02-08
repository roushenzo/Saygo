class CreatePageCustomFields < ActiveRecord::Migration
  def change
    create_table :page_custom_fields do |t|
      t.integer :page_id
      t.integer :custom_field_id

      t.timestamps
    end
  end
end
