class AddAttachmentDocumentToMessages < ActiveRecord::Migration[5.1]
  def self.up
    change_table :messages do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :messages, :document
  end
end
