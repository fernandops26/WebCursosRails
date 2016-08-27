class UserSessionsController < ApplicationController
 def new
  	@user=User.new
 end

 def create
 	puts params[:session_user].inspect
 	user=User.find_by(username: params[:session_user][:username])
 	if user && user.authenticated?(params[:session_user][:password]) && (user.type_user==2)
 		log_in_user(user)
 		params[:session_user][:remember_me]=="1" ? remember(user): forget(user)
 		redirect_to home_path
 	else
 		flash[:errors]=user.errors.full_messages
 		render :new
 	end
 end

 def destroy
 	log_out_user if logged_in_user?
 	redirect_to login_path

 end 

end
