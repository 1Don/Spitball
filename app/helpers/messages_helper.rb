module MessagesHelper
  def messages
  	@conversation = Conversation.find(params[:conversation_id])
	@messages = @conversation.messages
  
  end

end
