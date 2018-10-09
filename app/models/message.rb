class Message < ApplicationRecord
	belongs_to :user, :class_name => "User"
 belongs_to :conversation
 belongs_to :user
 validates_presence_of :body, :user_id
 has_attached_file :document
 validates_attachment_content_type :document, content_type: /\Atext\/.*\z/
end
