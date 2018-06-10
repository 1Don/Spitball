class AddTagsToWads < ActiveRecord::Migration[5.1]
  def change
    add_column :wads, :tags, :string
  end
end
