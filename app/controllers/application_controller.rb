class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  	def correct_user(id, remember_token)
		begin
			user = User.find_by(id: id)
		rescue ActiveRecord::RecordNotFound
			false
		end
		if (user.remember_token == User.encrypt(remember_token))
			true
		else
			false
		end
	end
end
