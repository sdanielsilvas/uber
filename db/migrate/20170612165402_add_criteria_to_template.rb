class AddCriteriaToTemplate < ActiveRecord::Migration[5.0]
  def change
  	add_column :templates, :criteria, :json
  end
end
