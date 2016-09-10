class SubsidiariesController < ApplicationController
 layout 'admin'
 before_filter :authenticate_user,:validate_admin
 before_action :set_subsidiary, only:[:show]

  	def index
  		if(params[:filtro_nombres])
			@consultas=Subsidiary.joins(:person,:programation).where("people.nombres || ' ' || people.ape_pat || '' || people.ape_mat ILIKE ?","%#{params[:filtro_nombres]}%").order('created_at desc')
		else
			@consultas=Subsidiary.all.order('created_at desc')
		end

		respond_to do |format|
	      format.html {render :index, status: :ok}
	      format.json {render json: @consultas.to_json(:include =>[{:programation=>{:include =>[:institution,:course]}},{:person=>{:include=>{:district=>{:include=>{:province=>{:include=>:department} } }} }}])}
	    end
  	end

  	def show
		respond_to do |format|
			format.json {render json: @consulta.to_json(:include =>[{:programation=>{:include =>[:institution,:course]}},{:person=>{:include=>{:district=>{:include=>{:province=>{:include=>:department} } }} }}])}
		end

  	end

  	#Actualizar el atributo leido de la sbsidiario
	def update_leido
	    consulta=set_subsidiary
    	if consulta.update_attributes(leido: params[:leido])
      		respond_to do |format|
        		format.json { head :no_content}
      		end
    	end
  	end


  	private
  	def set_subsidiary
  		@consulta=Subsidiary.find(params[:id])
  	end
end
