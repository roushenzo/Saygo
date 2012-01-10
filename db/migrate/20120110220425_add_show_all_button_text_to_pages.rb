class AddShowAllButtonTextToPages < ActiveRecord::Migration
  def change
    add_column :pages, :show_all_button_text, :string, :default => "\320\222\321\201\320\265 \320\264\320\276\321\201\321\202\320\276\320\277\321\200\320\270\320\274\320\265\321\207\320\260\321\202\320\265\320\273\321\214\320\275\320\276\321\201\321\202\320\270"
  end
end
