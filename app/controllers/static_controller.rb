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

 def verify
   @consulta=set_user
 end

 def aplicar
  @coordinator = Coordinator.new
 end

def add_aplicator
  @coordinator = Coordinator.new(coordinator_params)
  @coordinator.visto=false
  @coordinator.estado=false
  if @coordinator.save
    flash.now[:notice]="Felicidades acabas de postular como coordinador"
     @coordinator=Coordinator.new
  else
    flash.now[:error]="Sucedio un problema ent u postulación"
  end
  render :aplicar
 end


 def coordinators
  @coordinadores=Coordinator.all.where("estado = ?",true).order('nombres asc')
 end

 #get courses
 def courses
 	@categorias =Category.where('estado = ?',true).order('nombre ASC')


 	if(params[:category_id] && params[:t])
      @cursos=Course.where("category_id = ? and tipo= ?","#{params[:category_id]}","#{params[:t]}")
      @tipo_curso=params[:t]
  elsif(params[:t])
      @cursos=Course.where("tipo= ?","#{params[:t]}")
      @tipo_curso=params[:t]
  else
    @cursos=Course.where("tipo= 1")
    @tipo_curso=1
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
  if params[:t] 
    @tipo_curso=params[:t]
  else
    @tipo_curso=1
  end

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
 def set_course
 	@course = Course.find(params[:id])
 end

 def set_user
 User.joins(person:[:subsidiaries]).find_by(username:params[:username])
 end
 def query_params
 	params.require(:contact_query).permit(:nombres,:apellidos,:email,:telefono,:mensaje)
 end

  def coordinator_params
      params.require(:coordinator).permit(:nombres, :apellidos, :curriculum, :visto, :estado)
  end

  def person_params
    params.require(:person).permit(:nombres,:ape_pat,:ape_mat,:f_nacimiento,:district_id,:direccion,:sexo,:email,:celular,:celular_op,:dni,:profesion,:grado_acad, subsidiaries_attributes:[:programation_id])
  end

end
