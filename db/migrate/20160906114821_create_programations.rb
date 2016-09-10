class CreateProgramations < ActiveRecord::Migration
  def change
    create_table :programations do |t|
      t.text :descripcion
      t.text :objetivos
      t.integer :duracion
      t.integer :horas
      t.float :costo
      t.text :plan
      t.boolean :estado
      t.date :fecha
      t.references :institution, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
