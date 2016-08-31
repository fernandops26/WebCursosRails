class UsersController < ApplicationController
 before_action :authenticate_user, only:[:index]

 def index
 end

 def new
 	flash[:errores]=nil
 	@user=User.new
 	@person=Person.new
 	@distritos=District.all
 	@provincias=Province.all
 	@departamentos=Department.all
 end

 def create

 	@provincias=Province.all
 	@departamentos=Department.all
 	@user=User.new(user_params)
 	@user.type_user=2
 	if @user.save
 		log_in_user(@user)
 		redirect_to home_path
 	else
 		flash[:errores]=@user.errors.full_messages
 		render :new

 	end
 end



 private
	def user_params
		params.require(:user).permit(:username,:password,:password_confirmation)
	end

	def person_params
		params.require(:user).permit(person_attributes:[:nombre,:ape_pat,:ape_mat,:f_nacimiento,:district_id,:direccion,:sexo,:email])
	end
end
