class AddLinkWeightToDescriptionTypes < ActiveRecord::Migration
  def change
    add_column :description_types, :link_weight, :integer
  end
end
