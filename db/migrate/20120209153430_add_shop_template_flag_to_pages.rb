class AddShopTemplateFlagToPages < ActiveRecord::Migration
  def change
    add_column :pages, :shop_template, :boolean, :default => false
  end
end
