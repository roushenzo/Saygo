class RemoveWasteFieldsFromComments < ActiveRecord::Migration
  def up
    remove_column :comments, :commentable_id
    remove_column :comments, :commentable_type
    remove_column :comments, :user_id
  end

  def down
    add_column :comments, :commentable_type, :string
    add_column :comments, :commentable_id, :integer
    add_column :comments, :user_id, :integer
  end
end
