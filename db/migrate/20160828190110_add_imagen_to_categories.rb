class AddImagenToCategories < ActiveRecord::Migration
  def change
  	add_attachment :categories, :imagen
  end
end
