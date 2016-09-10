class ProgramationsController < ApplicationController
  before_action :set_programation, only: [:show, :edit, :update, :destroy]

  # GET /programations
  # GET /programations.json
  def index
    @programations = Programation.all
  end

  # GET /programations/1
  # GET /programations/1.json
  def show
  end

  # GET /programations/new
  def new
    @programation = Programation.new
  end

  # GET /programations/1/edit
  def edit
  end

  # POST /programations
  # POST /programations.json
  def create
    @programation = Programation.new(programation_params)
    @programation.modalities=params[:modalities]
    respond_to do |format|
      if @programation.save
        format.html { redirect_to @programation, notice: 'Programation was successfully created.' }
        format.json { render :show, status: :created, location: @programation }
      else
        format.html { render :new }
        format.json { render json: @programation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /programations/1
  # PATCH/PUT /programations/1.json
  def update
    respond_to do |format|
      if @programation.update(programation_params)
        format.html { redirect_to @programation, notice: 'Programation was successfully updated.' }
        format.json { render :show, status: :ok, location: @programation }
      else
        format.html { render :edit }
        format.json { render json: @programation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /programations/1
  # DELETE /programations/1.json
  def destroy
    @programation.destroy
    respond_to do |format|
      format.html { redirect_to programations_url, notice: 'Programation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_programation
      @programation = Programation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def programation_params
      params.require(:programation).permit(:descripcion, :objetivos, :duracion, :horas, :costo, :plan, :institution_id, :course_id)
    end
end
