class AddNameToTemplate < ActiveRecord::Migration[5.0]
  def change
  	add_column :templates, :name, :string
  end
end
