class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :rice

  validates :user_id, presence: true
  validates :rice_id, presence: true
  validates :bidding_price, presence: true, numericality: { greater_than: 0 }
  
  validate :validate_bidding_price_less_than_current_highest_bid

  validate :validate_bidding_price
  after_create :set_bid_end_time, :update_highest_bidder

  private

  def validate_bidding_price_less_than_current_highest_bid
    return unless rice.highest_bidder.present? && bidding_price.present?
  
    current_highest_bid = rice.bids.maximum(:bidding_price)
    if current_highest_bid.nil? || bidding_price <= current_highest_bid
      errors.add(:bidding_price, "must be higher than the current highest bid")
    end
  end
  

  def validate_bidding_price
    if bidding_price.present? && bidding_price <= rice.bidding_price
      errors.add(:bidding_price, "must be greater than the current bidding price")
    end
  end

  def set_bid_end_time
    rice.update(bid_end_time: 24.hours.from_now)
  end

  def update_highest_bidder
    if bidding_price.present? && bidding_price > rice.bidding_price
      previous_highest_bidder_id = rice.highest_bidder
      rice.update(highest_bidder: user_id)
      notify_outbid_user(previous_highest_bidder_id)
    end
  end
  def notify_outbid_user(user_id)
    outbid_user = User.find_by(id: user_id)
    return unless outbid_user
  
    rice = Rice.find_by(id: rice_id)
    return unless rice
  
    notification = Notification.new(
      user_id: user_id,
      title: "Outbid Notification",
      message: "Your bid has been outbid for the #{rice.name} rice. View the rice <a href='/rice/#{rice.id}'>here</a>."
    )
    notification.save
    # You can add additional code to send the notification to the user via email, push notification, etc.
  end
  
  def schedule_update_rice_ownership_job
    UpdateRiceOwnershipJob.set(wait_until: rice.bid_end_time).perform_later(rice.id)
  end
  
end
