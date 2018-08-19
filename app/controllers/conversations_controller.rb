class ConversationsController < ApplicationController
	layout 'wad', only: [:index]

	def index
		 @friends = current_user.friends

		 @names = []
		 @friends.each do |f|
		 	@names.push(f.name)
		 end

		 @ids = []
		 @friends.each do |f|
		 	@ids.push(f.id)
		 end	 

		 @conversations = Conversation.where(sender_id: current_user.id) + Conversation.where(recipient_id: current_user.id)

		 @conversationalists = []
		 User.all.each do |person|
		 	if person.conversation_with?(current_user)
		 		@conversationalists.push(person)
		 	end
		 end
		 @c = ["isaiah", "jeff", "tom"]
	end

	def create
	 if Conversation.between(current_user.id, params[:user_id]).exists?
	 	if Conversation.between(current_user.id, params[:user_id]).count > 1
	 		conversations = Conversation.between(current_user.id, params[:user_id])
	 		@conversation = conversations.shift
	 		conversations.each do |c|
	 			c.destroy
	 		end
	 	else 
	    	@conversation = Conversation.between(current_user.id, params[:user_id])
	   	end
	 else
	 	if current_user.id == params[:user_id]
	 		redirect_back
	 		flash[:notice] = "You can't have a conversation with yourself lolz"
	 	else
	    	@conversation = Conversation.create(sender_id: current_user.id, recipient_id: params[:user_id])
	    end
	 end
	 redirect_to conversation_messages_path(@conversation)
	end

	def autocomplete_friends
		search_conversation = Conversation.between(User.find_by_name(params[:autocomplete_friends]).id, current_user.id)
		if !search_conversation[0].nil?
			redirect_to conversation_messages_path(search_conversation[0].id)
		else
			create
		end
	end		

private
	 def conversation_params
	  params.permit(:sender_id, :recipient_id, :user)
	 end
end
