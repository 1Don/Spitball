class RemoveDuplicateFirstNameFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :firstname_string, :string
  end
end
