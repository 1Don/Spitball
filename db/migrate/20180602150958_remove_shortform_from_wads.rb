class RemoveShortformFromWads < ActiveRecord::Migration[5.1]
  def change
    remove_column :wads, :short_form, :text
  end
end
