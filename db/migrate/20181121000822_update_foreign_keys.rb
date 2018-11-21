class UpdateForeignKeys < ActiveRecord::Migration[5.2]
  def change
    # remove the old foreign_key
    remove_foreign_key :conversations, :users

    # add the new foreign_key
    add_foreign_key :conversations, :users, on_delete: :cascade
  end
end
