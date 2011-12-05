class AddSightOfTheDayToPages < ActiveRecord::Migration
  def change
    add_column :pages, :sight_of_the_day, :boolean, :default => false
  end
end
