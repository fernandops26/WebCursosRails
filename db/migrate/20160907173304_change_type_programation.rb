class ChangeTypeProgramation < ActiveRecord::Migration
  def up
    change_table :programations do |t|
      t.change :costo, :decimal, :precision => 8, :scale => 2
    end
  end

  def down
    change_table :programations do |t|
      t.change :costo, :float
    end
  end
end
