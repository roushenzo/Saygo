class DropInfoBlocks < ActiveRecord::Migration
  def up
    drop_table :info_blocks
  end

  def down
    create_table :info_blocks do |t|
      t.string :title
      t.text :content
      t.integer :page_id

      t.timestamps
    end
  end
end
