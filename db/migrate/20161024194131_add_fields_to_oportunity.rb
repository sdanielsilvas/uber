class AddFieldsToOportunity < ActiveRecord::Migration[5.0]
  def change
  	add_column :oportunities, :identification, :string
  	add_column :oportunities, :oportunity_source, :string
  	add_column :oportunities, :assigned_partner, :string
  	add_column :oportunities, :status, :string
  	add_column :oportunities, :company_name, :string
  	add_column :oportunities, :contact_email, :string
  end
end
