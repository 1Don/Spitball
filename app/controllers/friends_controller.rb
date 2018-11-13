class FriendsController < ApplicationController

  def index
    if current_user
  	   @friends = current_user.friends
    end
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
