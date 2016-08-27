class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :nombre
      t.string :descripcion
      t.boolean :estado

      t.timestamps null: false
    end
  end
end
