class ChangeIpType < ActiveRecord::Migration
 def change
   remove_column :comments, :ip
   add_column :comments, :ip, :string
 end
end
