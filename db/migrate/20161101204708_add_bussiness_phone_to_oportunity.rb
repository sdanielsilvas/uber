class AddBussinessPhoneToOportunity < ActiveRecord::Migration[5.0]
  def change
  	add_column :oportunities, :business_phone, :string
  end
end
