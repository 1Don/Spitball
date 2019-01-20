class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :task
      t.integer :giver
      t.integer :doer
      t.string :deadline
      t.text :notes
      t.string :priority

      t.timestamps
    end
  end
end
