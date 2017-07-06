class AddUserIdToOpportunity < ActiveRecord::Migration[5.0]
  def change
  	add_column :oportunities, :user_id, :int
  end
end
