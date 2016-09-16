class AdminsController < ApplicationController
 layout 'admin'
 before_filter :authenticate_user, :validate_admin

  def index
  end

    
  def profile
  	@user=User.find(current_user.id);
  end


  def update_profile
  	@user = User.find(current_user.id)
  	if params[:user][:password]==params[:user][:password_digest]
	  	if @user.update(params_user)
	    	flash.now[:notice]="Contraseña actualizada correctamente"
		else
	    	flash.now[:error]="Ocurrio algun error, comunicate con soporte"
		end
	else
		flash.now[:error]="Las contraseñas nos son iguales"
	end
	render :profile

  end


  private
  def params_user
  	params.require(:user).permit(:password,:password_digest)
  end


end
