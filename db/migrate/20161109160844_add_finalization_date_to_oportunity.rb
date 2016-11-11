class AddFinalizationDateToOportunity < ActiveRecord::Migration[5.0]
  def change
  	  	add_column :oportunities, :finalization_date, :datetime
  end
end
