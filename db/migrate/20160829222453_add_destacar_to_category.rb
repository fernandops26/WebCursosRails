class AddDestacarToCategory < ActiveRecord::Migration
  def change
  	add_column :categories, :destacar, :boolean
  end
end
