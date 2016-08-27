module UserSessionsHelper

	def log_in_user(user)
		session[:user_id]=user.id
	end


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

	def logged_in_user?
		!current_user.nil?
	end

	def is_user?
		current_user.type_user==2
	end

	def is_admin?
		current_user.type_user==1
	end

	def authenticate_user
		redirect_to login_path unless logged_in_user?
	end

	def validate_user
		redirect_to login_path unless is_user?
	end

	def validate_admin
		redirect_to admin_login_path unless is_admin?
	end

	def forget(user)
		user.delete_cookie
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end


	def log_out_user
		forget(current_user)
		session.delete(:user_id)
		@current_user=nil
	end

	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id]=user.id
		cookies.permanent.signed[:remember_token]=user.remember_token
	end

end
