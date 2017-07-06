class AddStatusToOpportunityProvider < ActiveRecord::Migration[5.0]
  def change
  	add_column :oportunity_providers, :status, :string
  end
end
