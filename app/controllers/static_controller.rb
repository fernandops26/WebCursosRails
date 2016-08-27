class StaticController < ApplicationController
 def index
 	@cursos=Course.all
 end

 def contact
 end

end
