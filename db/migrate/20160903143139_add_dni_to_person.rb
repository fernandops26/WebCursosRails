class AddDniToPerson < ActiveRecord::Migration
  def change
  	add_column :people, :dni, :string
  end
end
