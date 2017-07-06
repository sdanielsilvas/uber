class AddUserIdToTemplate < ActiveRecord::Migration[5.0]
  def change
  	add_column :templates, :user_id, :int
  	add_column :templates, :company, :string
  end
end
