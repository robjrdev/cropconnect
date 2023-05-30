class Rice < ApplicationRecord
    belongs_to :user
    has_many :bids
    has_many :ratings

    def bidding_open?
        bid_end_time.present? && bid_end_time > Time.now
    end
end
