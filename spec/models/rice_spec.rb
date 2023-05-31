require 'rails_helper'

RSpec.describe Rice, type: :model do
  let(:user) { create(:user) }
  let(:rice) { create(:rice, user: user) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:bids) }
    it { should have_many(:ratings) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:bidding_price) }
    it { should validate_numericality_of(:bidding_price).is_greater_than(0) }
    it { should validate_presence_of(:user_id) }
  end

  describe '#set_bid_end_time' do
    it 'updates the bid_end_time attribute' do
      rice.set_bid_end_time
      expect(rice.bid_end_time).to be_within(1.second).of(24.hours.from_now)
    end
  end

  describe '#bidding_open?' do
    it 'returns true if bid_end_time is present and in the future' do
      rice.update(bid_end_time: 1.day.from_now)
      expect(rice.bidding_open?).to eq(true)
    end

    it 'returns false if bid_end_time is not present' do
      rice.update(bid_end_time: nil)
      expect(rice.bidding_open?).to eq(false)
    end

    it 'returns false if bid_end_time is in the past' do
      rice.update(bid_end_time: 1.day.ago)
      expect(rice.bidding_open?).to eq(false)
    end
  end

  describe '#check_and_update_ownership' do
    let(:highest_bidder) { create(:user) }
    let!(:bid) { create(:bid, rice: rice, user: highest_bidder, bidding_price: 55) }
  
    it 'updates the user_id to the highest_bidder if bid_end_time is in the past and highest_bidder is present' do
      rice.update(bid_end_time: 1.day.ago)
      rice.check_and_update_ownership
      expect(rice.user_id).to eq(highest_bidder.id)
    end
  
    it 'does not update the user_id if bid_end_time is not in the past' do
      rice.update(bid_end_time: 1.day.from_now)
      rice.check_and_update_ownership
      expect(rice.user_id).to eq(user.id)
    end
  end
  
  describe '#check_and_update_ownership' do
    let(:user) { create(:user) }
    let(:rice) { create(:rice, user: user) }
    let(:highest_bidder) { create(:user) }
  
    context 'when bid_end_time is in the past and highest_bidder is present' do
      let!(:bid) { create(:bid, rice: rice, user: highest_bidder) }
  
      it 'updates the user_id to the highest_bidder' do
        rice.update(bid_end_time: 1.day.ago)
        rice.check_and_update_ownership
        expect(rice.user_id).to eq(highest_bidder.id)
      end
    end
  
    context 'when bid_end_time is not in the past' do
      let!(:bid) { create(:bid, rice: rice, user: highest_bidder) }
  
      it 'does not update the user_id' do
        rice.update(bid_end_time: 1.day.from_now)
        rice.check_and_update_ownership
        expect(rice.user_id).to eq(user.id)
      end
    end
  
    context 'when highest_bidder is not present' do
      it 'does not update the user_id' do
        rice.update(bid_end_time: 1.day.ago)
        rice.check_and_update_ownership
        expect(rice.user_id).to eq(user.id)
      end
    end
  end
  
  
end
