class UserSessionsController < ApplicationController
 def new
 	flash[:erorrs]=""
  	@user=User.new
 end

 def create
 	user=User.find_by(username: params[:session_user][:username])
 	if user && user.authenticated?(params[:session_user][:password]) && (user.type_user==2)
 		log_in_user(user)
 		params[:session_user][:remember_me]=="1" ? remember(user): forget(user)
 		redirect_to home_path
 	else
 		if !user.nil?
 			flash[:errors]="Usuario o contraseña correcta"
 		else
 			flash[:errors]="El usuario no existe"
 		end
 		render :new
 	end
 end

 def destroy
 	log_out_user if logged_in_user?
 	redirect_to login_path
 end 

end
