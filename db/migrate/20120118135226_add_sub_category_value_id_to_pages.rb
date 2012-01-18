class AddSubCategoryValueIdToPages < ActiveRecord::Migration
  def change
    add_column :pages, :sub_category_value_id, :integer
  end
end
