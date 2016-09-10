class CreateSubsidiaries < ActiveRecord::Migration
  def change
    create_table :subsidiaries do |t|
      t.references :person, index: true, foreign_key: true
      t.references :programation, index: true, foreign_key: true
      t.boolean :estado
      t.boolean :leido
      t.timestamps null: false
    end
  end
end
