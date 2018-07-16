class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :name,
                                 :email,
                                 :password,
                                 :password_confirmation,
                                 :occupation,
                                 :location,
                                 :interests,
                                 :twitter,
                                 :github,
                                 :linkedin)
  end

  def account_update_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :name,
                                 :email,
                                 :password,
                                 :password_confirmation,
                                 :current_password,
                                 :occupation,
                                 :location,
                                 :interests,
                                 :twitter,
                                 :github,
                                 :linkedin)
  end
end