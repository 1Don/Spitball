class SessionsController < Devise::SessionsController
  layout 'devise'

  def new
    super
  end
end