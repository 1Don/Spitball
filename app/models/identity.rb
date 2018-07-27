class Identity < ApplicationRecord
	belongs_to :user

#signup through omniauth
 	def self.sign_up_from_omniauth(auth)
    	create(uid: auth['uid'], provider: auth['provider'])
  	end

  # Find user by omniauth
   def self.find_with_omniauth(auth)
    find_by(uid: auth['uid'], provider: auth['provider'])
   end

end
