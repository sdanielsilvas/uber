class AddEmailToProvider < ActiveRecord::Migration[5.0]
  def change
  	add_column :providers, :email, :string
  end
end
