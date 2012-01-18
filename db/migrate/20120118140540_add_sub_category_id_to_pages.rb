class AddSubCategoryIdToPages < ActiveRecord::Migration
  def change
    add_column :pages, :sub_category_id, :integer
  end
end
