class FriendsController < ApplicationController
  before_action :require_login

  def index
    if !current_user
      redirect_to root_path
    else
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
