class CreateInfoBlocks < ActiveRecord::Migration
  def change
    create_table :info_blocks do |t|
      t.string :title
      t.text :content
      t.integer :page_id

      t.timestamps
    end
  end
end
