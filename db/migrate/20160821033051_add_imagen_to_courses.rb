class AddImagenToCourses < ActiveRecord::Migration
  def change
  	add_attachment :courses, :imagen
  end
end
