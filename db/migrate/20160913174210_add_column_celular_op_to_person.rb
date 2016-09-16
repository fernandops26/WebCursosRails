class AddColumnCelularOpToPerson < ActiveRecord::Migration
  def change
  	add_column :people,:celular_op,:string
  end
end
