class AddResolvedToDiscussions < ActiveRecord::Migration[5.1]
  def change
    add_column :discussions, :resolved, :boolean, :default => false
  end
end
