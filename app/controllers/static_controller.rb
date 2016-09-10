class StaticController < ApplicationController
	before_action :set_course, only:[:show]
 def index
 	@cursos=Course.joins(programations:[:institution]).order('created_at desc').limit(6)
 	@categorias=Category.where(destacar:true, estado:true)
 	@instituciones=Institution.all
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

 #get courses
 def courses
 	@categorias =Category.where('estado = ?',true).order('nombre ASC')


 	if(params[:category_id])
      @cursos=Course.where("category_id = ?","#{params[:category_id]}")
  else
    @cursos=Course.all
  end

 	respond_to do |format|
      format.html {render :courses, status: :ok}
      format.json {render json: @cursos.to_json(:include => :programations)}
  end
 end

 def search_courses

 	if(params[:category_id])
      @cursos=Course.where("category_id = ?","#{params[:category_id]}")
  else
    @cursos=Course.all
  end

  respond_to do |format|
    format.html {render :search_courses, status: :ok}
    format.json {render json: @cursos.to_json(:include => :programations)}
  end
 end

 def show
 	@categorias =Category.where('estado = ?',true).order('nombre ASC')

 end


 private
 def set_course
 	@course = Course.find(params[:id])
 end
 def query_params
 	params.require(:contact_query).permit(:nombres,:apellidos,:email,:telefono,:mensaje)
 end

end
