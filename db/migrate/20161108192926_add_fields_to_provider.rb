class AddFieldsToProvider < ActiveRecord::Migration[5.0]
  def change
  	add_column :providers, :nit, :string
  	add_column :providers, :name, :string
  end
end
