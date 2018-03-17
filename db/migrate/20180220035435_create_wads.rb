class CreateWads < ActiveRecord::Migration[5.1]
  def change
    create_table :wads do |t|
      t.references :user, foreign_key: true
      t.text :short_form
      t.text :long_form
      t.text :category
      t.text :problem_state

      t.timestamps
    end
     add_index :wads, [:category]
  end
end
