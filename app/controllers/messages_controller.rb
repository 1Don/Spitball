class MessagesController < ApplicationController
	layout "message", only:[:index]

 before_action :find_conversation, only: [:new, :create]


	def index
		redirect_to conversations_path
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
		 @message = Message.create(body: params[:body], conversation_id: params[:id], user_id: current_user.id)
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
