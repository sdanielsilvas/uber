class AddTemplateToOpportinities < ActiveRecord::Migration[5.0]
  def change
  	add_column :oportunities, :template_id, :int
  end
end
