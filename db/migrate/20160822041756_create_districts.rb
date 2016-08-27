class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.string :nombredist
      t.references :province, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
