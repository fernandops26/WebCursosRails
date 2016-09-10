class CoursesController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user, :validate_admin
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    if(params[:titulo_cur])
      @courses=Course.where('titulo ILIKE ?',"%#{params[:titulo_cur]}%")
    else
      #@courses = Course.all.order('fecha desc')
      @courses = Course.all
    end

    respond_to do |format|
      format.html {render :index, status: :ok}
      format.json {render json: @courses.to_json(:include => [:category,:programations])}
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @categorias=Category.all
    @course = Course.new
    @course.programations.build
    @modalidades=Modality.all
    @instituciones=Institution.all

  end

  # GET /courses/1/edit
  def edit
    @categorias=Category.all
    @modalidades=Modality.all
    @instituciones=Institution.all
  end

  # POST /courses
  # POST /courses.json
  def create
    @categorias=Category.all
    @course = Course.new(course_params)
    puts @course.inspect
    #@course.modalidades=params[:course][:programations_attributes]["0"][:modalities]
    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Curso creado correctamente.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update

    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Cuso actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Cuso eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:titulo, :category_id,:imagen, programations_attributes:[:id,:institution_id,:descripcion,:objetivos,:duracion,:horas,:costo,:plan,:fecha, :estado, :_destroy,modality_ids:[]])
      #params.require(:course).permit!
    end
end
