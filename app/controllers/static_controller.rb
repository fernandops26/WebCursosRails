class StaticController < ApplicationController
 def index
 	@cursos=Course.where('estado = ? and fecha >= ?',true,Date.today).order('created_at desc')
 	@categorias=Category.where(destacar:true, estado:true)
 end

 #get
 def contact
 	@consulta=ContactQuery.new
 end

 #post
 def create_query_contact
 	@consulta=ContactQuery.new(query_params)
 	if @consulta.save
 		@consulta=ContactQuery.new
 		flash.now[:notice]="Tu mensaje ha sido enviado correctamente, pronto nos comunicaremos contigo."
 		render :contact
 	else
 		render :contact
 	end
 		
 end

 private
 def query_params
 	params.require(:contact_query).permit(:nombres,:apellidos,:email,:telefono,:mensaje)
 end

end
