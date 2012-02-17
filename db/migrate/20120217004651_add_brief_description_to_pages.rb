class AddBriefDescriptionToPages < ActiveRecord::Migration
  def change
    add_column :pages, :brief_description, :text
  end
end
