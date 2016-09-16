class UsersController < ApplicationController
 layout 'admin'
  before_action :set_user, only: [:show,:edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.joins("LEFT OUTER JOIN people ON users.id=people.user_id").where('type_user=?',2)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(users_params)
    @user.type_user=2;

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Usuario creado correctamente.' }
        format.json { render show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(users_params)
        format.html { redirect_to @user, notice: 'Usuario actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Usuario eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def users_params
      params.require(:user).permit(:username,:password,:password_digest)
    end
end
