class AddNewFieldsToComments < ActiveRecord::Migration
  def change
      add_column :comments, :ip, :string
      add_column :comments, :rate, :integer
      add_column :comments, :email, :string
      add_column :comments, :user_name, :string
      add_column :comments, :description, :text
      add_column :comments, :page_id, :integer
      remove_column :comments, :title
      remove_column :comments, :comment
  end

end
