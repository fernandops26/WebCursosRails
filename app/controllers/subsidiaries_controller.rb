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
	      format.json {render json: @consultas.to_json(:include =>[{:programation=>{:include =>[:institution,:course]}},{:person=>{:include=>[{:district=>{:include=>{:province=>{:include=>:department} } }},:user]   }}])}
	    end
  	end

  	def show
		respond_to do |format|
			format.json {render json: @consulta.to_json(:include =>[{:programation=>{:include =>[:institution,:course]}},{:person=>{:include=>[{:district=>{:include=>{:province=>{:include=>:department} } }},:user] }}])}
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

  def update_estado
      subsidiary=Subsidiary.find(params[:id])
    if subsidiary.update_attributes(estado: params[:estado])
        respond_to do |format|
          format.json { render json: subsidiary.to_json(:include =>[{:programation=>{:include =>[:institution,:course]}},{:person=>{:include=>[{:district=>{:include=>{:province=>{:include=>:department} } }},:user]   }}])}
        end
    end
  end

  def update_credential
    subsidiary=Subsidiary.find(params[:id_subsidiary])
    user=User.new(params_user)
    user.type_user=2
    if user.save
      person=Person.find(params[:id])
        if person.update_attributes(user_id:user.id)
          respond_to do |format|
           format.json {render json: subsidiary.to_json(:include =>[{:programation=>{:include =>[:institution,:course]}},{:person=>{:include=>[{:district=>{:include=>{:province=>{:include=>:department} } }},:user]   }}])}
        end
      end
    else
      puts user.errors.messages
    end
  end


  	private
  	def set_subsidiary
  		@consulta=Subsidiary.find(params[:id])
  	end

    def params_user
      params.permit(:username,:password,:password_digest)
    end
end
