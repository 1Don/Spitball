class CreateCollaborations < ActiveRecord::Migration[5.1]
  def change
    create_table :collaborations do |t|
      t.integer :wad_id

      t.timestamps
    end
  end
end
