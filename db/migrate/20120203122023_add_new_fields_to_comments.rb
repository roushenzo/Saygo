class AddNewFieldsToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :ip, :string
    add_column :comments, :rate, :integer
    add_column :comments, :email, :string
    add_column :comments, :user_name, :string
    add_column :comments, :description, :text
    add_column :comments, :page_id, :integer
    remove_column :comments, :title
    remove_column :comments, :comment
  end

  def self.down
    remove_column :comments, :ip
    remove_column :comments, :rate
    remove_column :comments, :email
    remove_column :comments, :user_name
    remove_column :comments, :description
    remove_column :comments, :page_id
    add_column :comments, :title, :string
    add_column :comments, :comment, :text
  end
end
