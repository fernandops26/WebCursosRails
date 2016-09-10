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
 	@person.subsidiaries.build

 	if params[:prog]
 		if Programation.exists?(params[:prog])
 			@programacion_actual=Programation.find(params[:prog])
 		
 		end
 		
 	end

 end

 def create
 	@provincias=Province.all
 	@departamentos=Department.all

 	@person=Person.new(person_params)
 	if @person.save
 		@person=Person.new
 		@person.subsidiaries.build
 		flash.now[:notice]="La petición de registro de ha procesado correctamente, nos comunicaremos contigo en la brevedad posible."
 	end
	render :new

 end



 private
	def person_params
		params.require(:person).permit(:nombres,:ape_pat,:ape_mat,:f_nacimiento,:district_id,:direccion,:sexo,:email,:celular,:dni,:profesion,:grado_acad, subsidiaries_attributes:[:programation_id])
	end
end
