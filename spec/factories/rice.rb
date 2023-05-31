
FactoryBot.define do
    factory :rice do
      name { Faker::Food.dish }
      bidding_price { Faker::Number.decimal(l_digits: 2) }
      user
    end
  end
  