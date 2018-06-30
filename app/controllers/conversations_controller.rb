class ConversationsController < ApplicationController
	layout 'wad', only: [:index]

	def index
		 @friends = current_user.friends.all
		 @users = User.all
		 @conversations = Conversation.all
	end

	def create
		 if Conversation.between(current_user.id, params[:user_id]).present?
		    @conversation = Conversation.between(current_user.id, params[:user_id]).first
		 else
		    @conversation = Conversation.create(sender_id: current_user.id, recipient_id: params[:user_id])
		 end
		 redirect_to conversation_messages_path(@conversation)
	end

private
	 def conversation_params
	  params.permit(:sender_id, :recipient_id, :user)
	 end
end
