class AddHighestBidderToRice < ActiveRecord::Migration[7.0]
  def change
    add_column :rice, :highest_bidder, :integer
  end
end
