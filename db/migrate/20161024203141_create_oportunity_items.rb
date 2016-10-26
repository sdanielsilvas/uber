class CreateOportunityItems < ActiveRecord::Migration[5.0]
  def change
    create_table :oportunity_items do |t|

      t.timestamps
    end
  end
end
