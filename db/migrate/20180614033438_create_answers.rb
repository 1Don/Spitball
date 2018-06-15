class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.text :content
      t.integer :discussion_id
      t.integer :user_id

      t.timestamps
    end
  end
end
