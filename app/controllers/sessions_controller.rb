class SessionsController < ApplicationController

  def new
  end
=begin
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path
  end
=end 
  def create
    if params[:session]
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
          log_in user
          redirect_to user
        else
          flash.now[:danger] = 'Invalid email/password combination'
          render 'new'
        end
    else
      auth = request.env['omniauth.auth']
      # Find an identity here
      @identity = Identity.find_with_omniauth(auth)

      if @identity.nil?
        # If no identity was found, create a brand new one here
        @identity = Identity.sign_up_from_omniauth(auth)
      end

      if logged_in?
        if @identity.user == current_user
          # User is signed in so they are trying to link an identity with their
          # account. But we found the identity and the user associated with it 
          # is the current user. So the identity is already associated with 
          # this user. So let's display an error message.
          redirect_to root_url, notice: "Already linked that account!"
        else
          # The identity is not associated with the current_user so lets 
          # associate the identity
          @identity.user = current_user
          @identity.save
          redirect_to root_url, notice: "Successfully linked that account!"
        end
      else
        if @identity.user.present?
          # The identity we found had a user associated with it so let's 
          # just log them in here
          self.current_user = @identity.user
          redirect_to root_url, notice: "Signed in!"
        else
          # No user associated with the identity so we need to create a new one
          @identity.user = User.sign_up_from_omniauth(request.env['omniauth.auth'])
          log_in @identity.user
          redirect_to wads_path
        end
      end
    end
  end




  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end