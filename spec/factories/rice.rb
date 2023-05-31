
FactoryBot.define do
    factory :rice do
      name { Faker::Food.dish }
      bidding_price { 40 }
      user
    end
  end
  