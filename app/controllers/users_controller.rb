class UsersController < ApplicationController
  before_action :admin_access, only: [:index]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  #before_action :require_login, only: [:edit, :update, :new]

  def index
    @users = User.all

    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv }
    end
  end

  def show
    @user = User.find(params[:id])
    @wads = Wad.all
    @conversation = Conversation.between(current_user.id, @user.id)[0]
    @likes = []
    Wad.all.each do |wad|
      if @user.liked? wad
        @likes.push(wad)
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if !params[:user][:photo] || !@user.photo.attached?
      @user.giveAvatar
      @user.photo.attach(io: File.open(Rails.root.join('storage', 'temp_images', @user.name + ".jpg")), filename: @user.name, content_type: "image/jpg")
    end
    if @user.save
      UserMailer.welcome_email(@user).deliver_now
      log_in @user
      flash[:success] = "Welcome to Our Beta!"
      redirect_to "/wads"
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    if current_user.admin? #|| User.find(params[:id]) == current_user
      User.find(params[:id]).photo.purge
      User.find(params[:id]).destroy
      flash[:success] = "User deleted"
      redirect_to root_path
    end
  end

# User profile navigation
  def profile_comments
    show
  end

  def profile_wads
  end

  def profile_mail
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :first_name, :last_name, :github, :occupation,
        :twitter, :linkedin, :password_confirmation, :photo, :location, :email_notif_subscribe)
    end
    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
      	store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def admin_access
       unless current_user.id == 1 or current_user.id == 3
        redirect_to wads_path
       end 
    end
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def conversation_params
      params.permit(:sender_id, :recipient_id, :user)
    end


end
