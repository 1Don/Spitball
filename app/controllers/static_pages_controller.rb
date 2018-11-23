class StaticPagesController < ApplicationController
  layout "_landing", only: [:landing, :home]
  #skip_before_action :home_lock

  def beta_email
    b = BetaInfo.create(title: "email")
    b.emails << params[:emails]
    b.save
    flash[:notice] = "Beta Release: 11/13"
  end

  def help
  end

  def home
  end

  def about
    redirect_to wads_path
  end

  def notifications
    @notifications = Notification.where(recipient_id: current_user.id)
  end

  def terms
  end

  def landing
    if current_user
      redirect_to wads_path
    else
      @rankedwads = Wad.order(cached_votes_total: :desc)
    end
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
