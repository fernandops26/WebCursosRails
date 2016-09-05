class CreateModalities < ActiveRecord::Migration
  def change
    create_table :modalities do |t|
      t.string :nombremod

      t.timestamps null: false
    end
  end
end
