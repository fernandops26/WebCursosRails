class InstitutionsController < ApplicationController
  layout 'admin'
  before_action :set_institution, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user,:validate_admin

  # GET /intitutions
  # GET /intitutions.json
  def index
    if(params[:razon])
      @institutions=Institution.where('razon ILIKE ?',"%#{params[:razon]}%")
    else
      @institutions = Institution.all.order('razon asc')
    end

    respond_to do |format|
      format.html {render :index, status: :ok}
      format.json {render json: @institutions}
    end
  end

  # GET /intitutions/1
  # GET /intitutions/1.json
  def show
  end

  # GET /intitutions/new
  def new
    @institution = Institution.new
  end

  # GET /intitutions/1/edit
  def edit
  end

  # POST /intitutions
  # POST /intitutions.json
  def create
    @institution = Institution.new(institution_params)

    respond_to do |format|
      if @institution.save
        format.html { redirect_to @institution, notice: 'Institución creada correctamente.' }
        format.json { render :show, status: :created, location: @institution }
      else
        format.html { render :new }
        format.json { render json: @institution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /intitutions/1
  # PATCH/PUT /intitutions/1.json
  def update
    respond_to do |format|
      if @institution.update(institution_params)
        format.html { redirect_to @institution, notice: 'Institución actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @institution }
      else
        format.html { render :edit }
        format.json { render json: @institution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /intitutions/1
  # DELETE /intitutions/1.json
  def destroy
    @institution.destroy
    respond_to do |format|
      format.html { redirect_to institutions_url, notice: 'Institución ha sido elminada correctamente' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_institution
      @institution = Institution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def institution_params
      params.require(:institution).permit(:razon,:imagen)
    end
end
