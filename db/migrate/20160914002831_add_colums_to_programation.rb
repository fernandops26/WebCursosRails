class AddColumsToProgramation < ActiveRecord::Migration
  def change
  		remove_column :programations, :costo, :decimal, :precision => 8, :scale => 2
  		add_column :programations, :costo_matricula, :decimal, :precision => 8, :scale => 2
  		add_column :programations,:costo_mensualidad, :decimal, :precision => 8, :scale => 2
  		add_column :programations,:costo_certificacion, :decimal, :precision => 8, :scale => 2
  end
end
