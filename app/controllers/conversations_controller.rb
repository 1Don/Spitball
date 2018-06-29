class ConversationsController < ApplicationController
	layout 'wad', only: [:index]

	def index
		 @friends = current_user.friends.all
		 @users = User.all
		 @conversations = Conversation.all
	end

	def create
		 if Conversation.between(params[:sender_id],params[:recipient_id]).present?
		    @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
		 else
		    @conversation = Conversation.create(conversation_params)
		 end
		 redirect_to conversations_path(@conversation)
	end

private
	 def conversation_params
	  params.permit(:sender_id, :recipient_id, :user)
	 end
end
