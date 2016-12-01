class AddFieldsToCredentials < ActiveRecord::Migration[5.0]
  def change
  	add_column :credentials, :user_id, :int
  	add_column :credentials, :user_name, :string
  	add_column :credentials, :password, :string
  	add_column :credentials, :key, :string
  	add_column :credentials, :iv, :string
  end
end
