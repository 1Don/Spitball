class FriendshipsController < ApplicationController

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

