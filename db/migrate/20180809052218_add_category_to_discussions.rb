class AddCategoryToDiscussions < ActiveRecord::Migration[5.1]
  def change
    add_column :discussions, :category, :string
  end
end
