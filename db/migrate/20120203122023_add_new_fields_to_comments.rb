class AddNewFieldsToComments < ActiveRecord::Migration
  def change
      add_column :comments, :ip, :integer
      add_column :comments, :rate, :integer
      add_column :comments, :email, :string
      add_column :comments, :user_name, :string
      add_column :comments, :description, :text
      add_column :comments, :page_id, :integer
  end
end
