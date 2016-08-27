class ChangeDescriptionCategory < ActiveRecord::Migration
  def change
  	reversible do |dir|
  		change_table :categories do |t|
  			dir.up {t.change :descripcion, :text}
  			dir.down{t.change :descripcion, :string}
  		end
  	end
  end
end
