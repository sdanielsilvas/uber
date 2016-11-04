class AddAuctionIdToOportunity < ActiveRecord::Migration[5.0]
  def change
  	add_column :oportunities, :auction_id, :string
  end
end
