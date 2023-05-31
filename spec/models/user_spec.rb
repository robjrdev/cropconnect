require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:encrypted_password) }
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:contact_number) }
    it { should validate_presence_of(:address) }
  end

  describe 'associations' do
    it { should have_many(:rices) }
    it { should have_many(:bids) }
    it { should have_many(:notifications) }
  end
end
