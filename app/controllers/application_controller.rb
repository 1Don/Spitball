class ApplicationController < ActionController::Base
  before_action :initialize_omniauth_state
<<<<<<< HEAD
#  before_action :home_lock
=======
  #before_action :home_lock
>>>>>>> e81223b2a5f198802c64b4e1bd435b519e760779


  protected

  def initialize_omniauth_state
    session['omniauth.state'] = response.headers['X-CSRF-Token'] = form_authenticity_token
  end

  def home_lock
    redirect_to root_path
  end

  #protect_from_forgery with: :exception
  include SessionsHelper
  include WadsAndCommentsHelper
  include AnswersHelper
end
