class Conversation < ApplicationRecord
    has_many :users, through: :conversation_users
	belongs_to :user, optional:true
	belongs_to :sender, class_name: 'User', optional:true
 	belongs_to :recipient, class_name: 'User', optional:true
	has_many :messages, dependent: :destroy
	validates_uniqueness_of :sender_id, :scope => :recipient_id
	scope :between, ->(sender_id, recipient_id) do
   		where('(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =?)', sender_id,recipient_id, recipient_id, sender_id)
	end
end