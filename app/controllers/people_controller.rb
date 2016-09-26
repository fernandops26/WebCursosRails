class PeopleController < ApplicationController
  layout 'admin'
  before_action :authenticate_user,:validate_admin
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
    @people = Person.all.order(:nombres)
  end

  # GET /people/1
  # GET /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
    @person.subsidiaries.build
    @departamentos=Department.all
    @distritos=District.all
    @provincias=Province.all
    @categorias=Category.all
    @programaciones=Programation.all
  end

  # GET /people/1/edit
  def edit

    @departamentos=Department.all
    @distritos=District.all
    @provincias=Province.all
    @categorias=Category.all
  end

  # POST /people
  # POST /people.json
  def create
    @departamentos=Department.all
    @distritos=District.all
    @provincias=Province.all
    @categorias=Category.all
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person creada correctamente.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update

    @departamentos=Department.all
    @distritos=District.all
    @provincias=Province.all
    @categorias=Category.all
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Persona actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person correctamente eliminada.' }
      format.json { head :no_content }
    end
  end

  def obtener_cursos
    @programaciones=Programation.joins(:course).where('courses.tipo = ? and courses.category_id = ?',params[:tipo_curso],params[:categoria])
    #@cursos=Course.where('courses.tipo = ? and category_id = ?',params[:tipo_curso],params[:categoria])
    respond_to do |format|
      format.json {render json: @programaciones.to_json(:include=>[:institution,:course])}
    end
  end

   def obtener_usuarios
    if current_user

      if params[:id_user_edit]
        @users=User.joins('LEFT OUTER JOIN "people" ON "users"."id" = "people"."user_id"').all.where('type_user=2 and (people.id is null or users.id= ?)',params[:id_user_edit])
      else

      @users=User.joins('LEFT OUTER JOIN "people" ON "users"."id" = "people"."user_id"').all.where('type_user=2 and people.id is null')
      end
      #@cursos=Course.where('courses.tipo = ? and category_id = ?',params[:tipo_curso],params[:categoria])
      respond_to do |format|
        format.json {render json: @users.to_json}
      end
    end
  end

  def obtener_programacion
    @programacion=Programation.find(params[:programacion_id])

    respond_to do |format|
      format.json {render json: @programacion.to_json(:include=>[:institution,:course])}
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:id,:nombres, :ape_pat, :ape_mat, :sexo, :f_nacimiento, :celular, :email, :district_id, :direccion, :profesion, :grado_acad, :user_id, :dni, :celular_op,subsidiaries_attributes:[:id,:programation_id,:estado,:leido,:_destroy])
    end

end
