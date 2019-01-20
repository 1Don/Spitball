class ConversationsController < ApplicationController
	before_action :require_login
	layout 'conversation', only: [:index]

	def index
		@conversation = Conversation.new
		@message = Message.new
		@conversations = Conversation.where(sender_id: current_user.id) + Conversation.where(recipient_id: current_user.id)

		@conversationalists = []
		User.all.each do |person|
		 	if person.conversation_with?(current_user)
		 		@conversationalists.push(person)
		 	end
		end
	end

	def show
		redirect_to conversations_path
	end

	def create_message
		@conversation = Conversation.find(params[:conversation_id])
		@message = current_user.messages.create(message_params)
		@message.conversation_id = @conversation.id
		@message.save!
		arr = []
		arr.push(User.find(@conversation.sender_id), User.find(@conversation.recipient_id))
		new_arr = arr.select {|item| current_user != item}
		user = new_arr[0]
		Notification.create(recipient: user, actor: current_user, action: "sent you", notifiable: @message)
		respond_to do |format|
			format.html { redirect_to conversations_path(conversation_id: @conversation.id) }
			format.js	{render 'create_message'}
		end
	end

	def create
		unless User.find(params[:user_id]) == current_user
		 if Conversation.between(current_user.id, params[:user_id]).exists?
		 	if Conversation.between(current_user.id, params[:user_id]).count > 1
		 		conversations = Conversation.between(current_user.id, params[:user_id])
		 		@conversation = conversations.shift
		 		conversations.each do |c|
		 			c.destroy
		 		end
		 	else
		    	@conversation = Conversation.between(current_user.id, params[:user_id])[0]
		   	end
		 else
		 	if current_user.id == params[:user_id]
		 		redirect_back
		 		flash[:notice] = "You can't have a conversation with yourself!"
		 	else
		    	@conversation = Conversation.create(sender_id: current_user.id, recipient_id: params[:user_id])
		    end
		 end
		 redirect_to conversation_messages_path(@conversation)
	 else
		 redirect_back(fallback_location: wads_path)
		 flash[:notice] = "You must be friends to message this person"
	 end
	end

private

	 def conversation_params
	  params.permit(:sender_id, :recipient_id, :user)
	 end

	 def message_params
		 params.require(:message).permit(:body, :document)
	 end
end
