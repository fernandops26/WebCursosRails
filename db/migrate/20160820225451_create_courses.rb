class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :titulo
      t.text :contenido
      t.references :category, index: true, foreign_key: true
      t.date :fecha
      t.boolean :estado

      t.timestamps null: false
    end
  end
end
