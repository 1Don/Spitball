class FriendRequestsController < ApplicationController
<<<<<<< HEAD
  before_action :set_friend_request, except: [:index, :create]
=======
	 layout 'wad', only: [:index]
	 before_action :set_friend_request, except: [:index, :create]
>>>>>>> development

  def create
    friend = User.find(params[:friend_id])
    @friend_request = current_user.friend_requests.new(friend: friend)

    if @friend_request.save
<<<<<<< HEAD
      render :show, status: :created, location: @friend_request
      flash[:notice] = "Request sent"
    else
      render json: @friend_request.errors, status: :unprocessable_entity
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
  head :no_content
  end

=======
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

  def destroy
	current_user.remove_friend(@friend)
	head :no_content
  end
>>>>>>> development

 private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end
<<<<<<< HEAD
=======

>>>>>>> development
end
