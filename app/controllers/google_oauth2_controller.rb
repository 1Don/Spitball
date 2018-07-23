class GoogleOauth2Controller < ApplicationController

  def callback
    user = User.from_omniauth(request.env['omniauth.auth'])

    if user.blank?
      # User not registered
      user = User.sign_up_from_omniauth(request.env['omniauth.auth'])
      log_in user
    elsif user.present?
      # User trying to login
      log_in user
    else
      return redirect_to login_url, notice: 'There was an error'
    end

    # Redirect to the URL you want after successful auth
    redirect_to wads_url
  end

  def failure
    # show a failure page or redirect to an error page
    @error_msg = request.params['message']
    redirect_to root_url
  end
end
