class AddBidEndTimeToRice < ActiveRecord::Migration[7.0]
  def change
    add_column :rice, :bid_end_time, :datetime
  end
end
