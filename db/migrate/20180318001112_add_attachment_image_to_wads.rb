class AddAttachmentImageToWads < ActiveRecord::Migration[5.1]
  def self.up
    change_table :wads do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :wads, :image
  end
end
