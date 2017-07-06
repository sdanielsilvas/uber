class CreateCapabilitiesProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :capabilities_products do |t|
    	t.integer :capability_id
      	t.integer :product_id
    	t.belongs_to :capability, index: true
      	t.belongs_to :product, index: true
    end
  end
end
