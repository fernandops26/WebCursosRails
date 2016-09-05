class AddImagenToInstitution < ActiveRecord::Migration
  def change
  	add_attachment :institutions, :imagen
  end
end
