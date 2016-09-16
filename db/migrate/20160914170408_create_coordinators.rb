class CreateCoordinators < ActiveRecord::Migration
  def change
    create_table :coordinators do |t|
      t.string :nombres
      t.string :apellidos
      t.string :curriculum
      t.boolean :visto
      t.boolean :estado

      t.timestamps null: false
    end
  end
end
