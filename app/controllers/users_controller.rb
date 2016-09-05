class UsersController < ApplicationController
 before_action :authenticate_user, only:[:index]

 def index
 end

 def new
 	flash[:errores]=nil
 	@person=Person.new
 	@distritos=District.all
 	@provincias=Province.all
 	@departamentos=Department.all
 end

 def create
 	@provincias=Province.all
 	@departamentos=Department.all

 	@person=Person.new(person_params)
 	if @person.save
 		@person.new
 		flash.now[:notice]="La peticion de registro de ha procesado correctamente, el administrador se comunicara contigo"
 	end
	render :new

 end



 private
	def user_params
		params.require(:user).permit(:username,:password,:password_confirmation)
	end

	def person_params
		params.require(:person).permit(:nombre,:ape_pat,:ape_mat,:f_nacimiento,:district_id,:direccion,:sexo,:email,:dni,:profesion,:grado_acad)
	end
end
