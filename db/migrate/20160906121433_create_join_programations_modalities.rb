class CreateJoinProgramationsModalities < ActiveRecord::Migration
  def self.up
  	create_table :modalities_programations, id:false do |t|
  		t.integer :modality_id
  		t.integer :programation_id
  	end
  	add_index :modalities_programations, :modality_id
  	add_index :modalities_programations, :programation_id
  end
  def self.down
  	drop_table :modalities_programations
  end
end
