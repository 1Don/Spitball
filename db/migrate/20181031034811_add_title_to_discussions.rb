class AddTitleToDiscussions < ActiveRecord::Migration[5.1]
  def change
    add_column :discussions, :title, :string
  end
end
