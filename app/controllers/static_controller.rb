class StaticController < ApplicationController
 def index
 	@cursos=Course.all
 	@categorias=Category.where(destacar:true)
 end

 def contact
 end

end
