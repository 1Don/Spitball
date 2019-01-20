class AddFoundersAndContributorsToCollaborations < ActiveRecord::Migration[5.2]
  def change
    add_column :collaborations, :founders, :integer, array:true, default: []
    add_column :collaborations, :contributors, :integer, array:true, default: []
  end
end
