class FriendshipsController < ApplicationController

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