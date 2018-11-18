class AddLinkToWad < ActiveRecord::Migration[5.2]
  def change
    add_column :wads, :link, :string
  end
end
