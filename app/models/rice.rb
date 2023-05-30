class Rice < ApplicationRecord
    belongs_to :user
    has_many :bids
    has_many :ratings
    after_create :set_bid_end_time

    def set_bid_end_time
       update(bid_end_time: 24.hours.from_now)
    end

    def bidding_open?
      bid_end_time.present? && bid_end_time > Time.now
    end
end
