class RemoveOldFieldsFromComments < ActiveRecord::Migration
 def change

   remove_column :comments, :title
   remove_column :comments, :comment

 end
end
