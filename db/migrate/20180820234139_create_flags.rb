class CreateFlags < ActiveRecord::Migration[5.1]
  def change
    create_table :flags do |t|
      t.references :user, foreign_key: true
      t.references :wad, foreign_key: true
      t.references :comment, foreign_key: true
      t.references :discussion, foreign_key: true
      t.references :answer, foreign_key: true
      t.string :type

      t.timestamps
    end
    add_index :flags, [:user_id, :wad_id, :comment_id, :discussion_id, :answer_id], name: 'by_flagged_content_id', unique: true
  end
end
