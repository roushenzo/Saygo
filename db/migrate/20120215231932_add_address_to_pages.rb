class AddAddressToPages < ActiveRecord::Migration
  def change
    add_column :pages, :address, :string
  end
end
