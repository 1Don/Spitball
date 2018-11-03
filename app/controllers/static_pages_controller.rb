class StaticPagesController < ApplicationController
layout "_landing", only: [:landing, :home]
#skip_before_action :home_lock

  def beta_email
    b = BetaInfo.create(title: "email")
    b.emails << params[:email]
    b.save
    flash[:notice] = "Beta Release: 11/13"
  end
  def home
  end

  def help
  end

  def about
  end

  def landing
    @rankedwads = Wad.order(cached_votes_total: :desc)
  end

  def search
    if !params[:search].empty?
    	@wads = Wad.search(params[:search])
    	@discussions = Discussion.search(params[:search])
    	@users = User.search(params[:search])
    else
      redirect_back(fallback_location: wads_path)
      flash[:notice] = "Please enter some search terms"
    end
  end
end
