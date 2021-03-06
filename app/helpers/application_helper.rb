module ApplicationHelper
	def current_user
		if(user_id=session[:user_id])
			@current_user ||=User.find_by(id:user_id)
		elsif (user_id=cookies.signed[:user_id])
			user=User.find_by(id:user_id)

			if user && user.authenticated?(cookies[:remember_token])
				log_in_user(user)
				@current_user=user
			end
		end
	end

	def log_in_user(user)
		session[:user_id]=user.id
	end

end
