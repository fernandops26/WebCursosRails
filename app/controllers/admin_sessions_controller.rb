class AdminSessionsController < ApplicationController

	layout nil ,:only =>[:new]
 def new
 	flash[:erorrs]=""
  	@user=User.new
 end

 def create
 	puts params[:session_admin].inspect
 	user=User.find_by(username: params[:session_admin][:username])
 	if user && user.authenticated?(params[:session_admin][:password]) && (user.type_user==1)
 		log_in_user(user)
 		redirect_to admin_home_path
 	else
 		if !user.nil?
 			flash[:errors]="Usuario o contraseña inválido"
 		else
 			flash[:errors]="El usuario no existe"
 		end
 		render :new
 	end
 end

 def destroy
 	log_out_user if logged_in_user?
 	redirect_to admin_login_path
 end 
end
