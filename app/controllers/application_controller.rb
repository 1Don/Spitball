class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper
  include WadsAndCommentsHelper
  include AnswersHelper

  def authenticate_user!(options = {})
    head :unauthorized unless signed_in?
  end

  def current_user
    @current_user ||= super
  end

  def signed_in?
    @current_user_id.present?
  end
end