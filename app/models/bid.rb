class Bid < ApplicationRecord
    belongs_to :user
    belongs_to :rice
  
    validate :validate_bidding_price
    after_create :set_bid_end_time, :update_highest_bidder
  
    private
  
    def validate_bidding_price
      if bidding_price.present? && bidding_price <= rice.bidding_price
        errors.add(:bidding_price, "must be greater than the current bidding price")
      end
    end
    
  
    def set_bid_end_time
      rice.update(bid_end_time: 24.hours.from_now)
    end
  
    def update_highest_bidder
      rice.update(highest_bidder: user_id) if bidding_price > rice.bidding_price
    end
end
