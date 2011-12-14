class RemoveUrlFromPages < ActiveRecord::Migration
  def up
    remove_column :pages, :url
  end

  def down
    add_column :pages, :url, :string
  end
end
