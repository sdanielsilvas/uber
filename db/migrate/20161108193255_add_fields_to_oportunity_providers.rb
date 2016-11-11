class AddFieldsToOportunityProviders < ActiveRecord::Migration[5.0]
  def change
  	add_column :oportunity_providers, :provider_nit, :string
  	add_column :oportunity_providers, :oportunity_identification, :string
  	add_column :oportunity_providers, :email, :string
  	add_column :oportunity_providers, :position, :string
  	add_column :oportunity_providers, :vendor_name, :string
  	add_column :oportunity_providers, :points, :string
  end
end
