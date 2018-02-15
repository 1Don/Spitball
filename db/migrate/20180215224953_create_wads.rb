class CreateWads < ActiveRecord::Migration[5.1]
  def change
    create_table :wads do |t|
      t.references :user, foreign_key: true
      t.string :category
      t.string :problem_statement
      t.string :short_form
      t.text :long_form

      t.timestamps
    end
  end
end
