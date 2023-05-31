class Rice < ApplicationRecord
    belongs_to :user
    has_many :bids
    has_many :ratings
    after_create :set_bid_end_time

    validates :name, presence: true
    validates :bidding_price, presence: true, numericality: { greater_than: 0 }
    validates :user_id, presence: true
  

    def set_bid_end_time
       update(bid_end_time: 24.hours.from_now)
    end

    def bidding_open?
      bid_end_time.present? && bid_end_time > Time.now
    end

    def check_and_update_ownership
      return unless bid_end_time.present? && bid_end_time <= Time.now
    
      if highest_bidder.present? && highest_bidder.bidding_price > bidding_price
        update(user_id: highest_bidder)
        # You can also perform additional actions here, such as sending a notification to the highest bidder.
      end
    end
    
end
