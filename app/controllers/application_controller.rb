class ApplicationController < ActionController::Base
  before_action :initialize_omniauth_state

  protected

  def initialize_omniauth_state
    session['omniauth.state'] = response.headers['X-CSRF-Token'] = form_authenticity_token
  end

  #protect_from_forgery with: :exception
  include SessionsHelper
  include WadsAndCommentsHelper
  include AnswersHelper
end