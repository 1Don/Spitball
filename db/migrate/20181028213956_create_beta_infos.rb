class CreateBetaInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :beta_infos do |t|
      t.string :title
      t.text :emails, array:true, default: []

      t.timestamps
    end
  end
end
