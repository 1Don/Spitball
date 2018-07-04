class FriendshipsController < ApplicationController

<<<<<<< HEAD
	  def create
	  @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
	  if @friendship.save
	    flash[:notice] = "Connection Request Sent"
	   	redirect_to :back
	   		  else
	    flash[:notice] = "Something bad happened"
	    redirect_to root_url
	  end
	end
	
end

=======
  def create
  end

  def index
  	@friends = current_user.friends
  end

  def destroy
	  current_user.remove_friend(@friend)
	  head :no_content
  end

private
  def set_friend
    @friend = current_user.friends.find(params[:id])
  end
end
>>>>>>> development
