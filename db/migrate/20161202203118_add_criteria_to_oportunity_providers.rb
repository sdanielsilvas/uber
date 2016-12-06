class AddCriteriaToOportunityProviders < ActiveRecord::Migration[5.0]
  def change
  	add_column :oportunity_providers, :price, :string
  	add_column :oportunity_providers, :training_hours, :string
  	add_column :oportunity_providers, :support_hours, :string
  	add_column :oportunity_providers, :local_support, :string
  	add_column :oportunity_providers, :support_availability, :string
  	add_column :oportunity_providers, :migration_hours, :string
  end
end
