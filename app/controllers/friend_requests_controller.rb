class FriendRequestsController < ApplicationController
   before_action :set_friend_request, except: [:index, :create]

  def create
    friend = User.find(params[:friend_id])
    @friend_request = current_user.friend_requests.new(friend: friend)

    if @friend_request.save
      Notification.create(recipient: User.find(params[:friend_id]), actor: current_user, action: "sent you", notifiable: @friend_request)
      redirect_to friend
      flash[:notice] = "Request Sent"
    else
      redirect_to friend
      flash[:notice] = "You've already sent a request!"
    end
  end

  def index
    @incoming = FriendRequest.where(friend: current_user)
    @outgoing = current_user.friend_requests
  end

  def destroy
  @friend_request.destroy
  head :no_content
  end

  def update
  @friend_request.accept
  redirect_to @friend_request.user
  flash[:notice] = "You're now connected"
  end


 private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end

end
