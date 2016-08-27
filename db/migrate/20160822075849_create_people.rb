class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :nombres
      t.string :ape_pat
      t.string :ape_mat
      t.boolean :sexo
      t.date :f_nacimiento
      t.integer :celular
      t.string :email
      t.references :district, index: true, foreign_key: true
      t.string :direccion
      t.string :profesion
      t.string :grado_acad

      t.timestamps null: false
    end
  end
end
