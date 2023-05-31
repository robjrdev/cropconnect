class Rice < ApplicationRecord
    belongs_to :user
    has_many :bids, dependent: :delete_all
    has_many :ratings, dependent: :delete_all
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
      if bid_end_time.present? && bid_end_time < Time.now && highest_bidder.present?
        update(user_id: highest_bidder)
      end
    end
    
end
