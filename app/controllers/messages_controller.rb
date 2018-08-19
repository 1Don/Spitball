class MessagesController < ApplicationController
	layout "message", only:[:index]

 before_action :find_conversation, only: [:new, :create]


	def index
		@conversation = Conversation.find(params[:conversation_id])
		@conversations = (Conversation.where(sender_id: current_user.id). or Conversation.where(recipient_id: current_user.id)).order('updated_at DESC')
		@convo = (Conversation.where(sender_id: current_user.id). or Conversation.where(recipient_id: current_user.id)).first
		@messages = @conversation.messages	
		  if @messages.length > 10
		   @over_ten = true
		   @messages = @messages[-10..-1]
	 	  end

		  if params[:m]
				@over_ten = false
				@messages = @conversation.messages
		  end

			if @messages.last
				  if @messages.last.user_id != current_user.id
				   @messages.last.read = true;
				  end
			end
			@message = @conversation.messages.new


		 @conversationalists = []
		 User.all.each do |person|
		 	if person.conversation_with?(current_user)
		 		@conversationalists.push(person)
		 	end
		 end			
	end


	def new
	 	@message = @conversation.messages.new
	end


	def create
		 @message = @conversation.messages.build(message_params)
		 @message.save
	end



	private

	 def userconvo

	 end


	 def message_params
	  	params.require(:message).permit(:body, :user_id)
	 end

	 def find_conversation
	 	@conversation = Conversation.find(params[:conversation_id])
	 end
end
