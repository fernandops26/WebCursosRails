class CreateContactQueries < ActiveRecord::Migration
  def change
    create_table :contact_queries do |t|
      t.string :nombres
      t.string :apellidos
      t.string :email
      t.string :telefono
      t.text :mensaje
      t.boolean :leido

      t.timestamps null: false
    end
  end
end
