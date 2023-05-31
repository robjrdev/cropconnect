FactoryBot.define do
    factory :rating do
      age { Faker::Number.between(from: 1, to: 100) }
      whiteness { Faker::Number.between(from: 1, to: 10) }
      dryness { Faker::Number.between(from: 1, to: 10) }
      pureness { Faker::Number.between(from: 1, to: 10) }
      rice
    end
  end