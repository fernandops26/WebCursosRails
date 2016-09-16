class AddTipoToCourse < ActiveRecord::Migration
  def change
  	add_column :courses,:tipo,:integer
  end
end
