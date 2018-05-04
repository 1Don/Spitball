class AddShortformbackToWads < ActiveRecord::Migration[5.1]
  def change
    add_column :wads, :short_form, :string
  end
end
