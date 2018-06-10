class AddTagsToDiscussions < ActiveRecord::Migration[5.1]
  def change
    add_column :discussions, :tags, :string
  end
end
