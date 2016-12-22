class AddCurrentProviderToOpportunity < ActiveRecord::Migration[5.0]
  def change
  	add_column :oportunities, :current_provider, :string
  end
end
