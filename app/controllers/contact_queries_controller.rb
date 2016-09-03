class ContactQueriesController < ApplicationController
	layout 'admin'
  	before_filter :authenticate_user,:validate_admin
  	before_action :set_contact_query, only:[:show]
  

	def index
		if(params[:filtro_nombres])
			@consultas=ContactQuery.where("nombres || ' ' || apellidos ILIKE ?","%#{params[:filtro_nombres]}%").order('created_at desc')
		else
			@consultas=ContactQuery.all.order('created_at desc')
		end

		respond_to do |format|
	      format.html {render :index, status: :ok}
	      format.json {render json: @consultas}
	    end
	end

	def show
		respond_to do |format|
			format.json {render json:@consulta}
		end

  	end

  	#Actualizar el atributo leido de la consulta de contacto
	def update_leido
	    consulta=set_contact_query
    	if consulta.update_attributes(leido: params[:leido])
      		respond_to do |format|
        		format.json { head :no_content}
      		end
    	end
  	end


  	private
  	def set_contact_query
  		@consulta=ContactQuery.find(params[:id])
  	end
end
