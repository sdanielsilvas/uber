class AddFieldsToOportunityItem < ActiveRecord::Migration[5.0]
  def change
  	add_column :oportunity_items, :oportunity_id, :int
  	add_column :oportunity_items, :oportunity_identification, :string
  	add_column :oportunity_items, :product, :string
  	add_column :oportunity_items, :sku, :string
  	add_column :oportunity_items, :quantity, :string
  	add_column :oportunity_items, :unit_price, :string
  end
end
