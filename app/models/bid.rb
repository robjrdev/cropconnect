class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :rice

  validate :validate_bidding_price
  after_create :update_highest_bidder

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
    if bidding_price > rice.bidding_price
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
  end
  
  def schedule_update_rice_ownership_job
    UpdateRiceOwnershipJob.set(wait_until: rice.bid_end_time).perform_later(rice.id)
  end
  
end
