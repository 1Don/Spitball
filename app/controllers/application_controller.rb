class ApplicationController < ActionController::Base
  before_action :initialize_omniauth_state
  #before_action :home_lock


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
