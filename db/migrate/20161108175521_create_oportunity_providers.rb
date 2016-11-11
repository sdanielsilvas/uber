class CreateOportunityProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :oportunity_providers do |t|

      t.timestamps
    end
  end
end
