class AdminSessionsController < ApplicationController

	layout nil ,:only =>[:new]
 def new
  	@user=User.new
 end

 def create
 	puts params[:session_admin].inspect
 	user=User.find_by(username: params[:session_admin][:username])
 	if user && user.authenticated?(params[:session_admin][:password]) && (user.type_user==1)
 		log_in_user(user)
 		redirect_to admin_home_path
 	else
 		flash[:errors]=user.errors.full_messages
 		render :new
 	end
 end

 def destroy
 	log_out_user if logged_in_user?
 	redirect_to admin_login_path
 end 
end
