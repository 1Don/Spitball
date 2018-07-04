class StaticPagesController < ApplicationController
layout "_landing", only: [:landing, :home]

  def home
  end

  def help
  end

  def about
  end

  def landing
  end

  def search
  	@wads = Wad.search(params[:search])
  	@discussions = Discussion.search(params[:search])
  	@users = User.search(params[:search])
  end 
end
