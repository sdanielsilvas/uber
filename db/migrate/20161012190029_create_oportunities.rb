class CreateOportunities < ActiveRecord::Migration[5.0]
  def change
    create_table :oportunities do |t|

      t.timestamps
    end
  end
end
