class CategoriesController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user,:validate_admin
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    if(params[:nombre_cat])
      @categories=Category.where('nombre ILIKE ?',"%#{params[:nombre_cat]}%")
    else
      @categories = Category.all.order('nombre asc')
    end

    respond_to do |format|
      format.html {render :index, status: :ok}
      format.json {render json: @categories}
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Categoria correctamente creada' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Categoria correctamente actualizada' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  #Actualizar el atributo de destacar de una categoria
  def update_destacar
    category=set_category
    if category.update_attributes(destacar: params[:destacar])
      respond_to do |format|
        format.json { head :no_content}
      end
    end
  end




  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:nombre, :descripcion, :imagen,:estado)
    end

    def set_search
      @categories=Category.where(nombre:params[:nombre_cat])
    end
end