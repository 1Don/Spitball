class StaticPagesController < ApplicationController
  layout 'static', only: [:home]

  before_action :authenticate_user!, only: :search

  def home
  end

  def help
  end

  def about
  end

  def search
  	@wads = Wad.search(params[:search])
  	@discussions = Discussion.search(params[:search])
  	@users = User.search(params[:search])
  end 
end
