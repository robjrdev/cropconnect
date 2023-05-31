FactoryBot.define do
    factory :notification do
      title { Faker::Lorem.sentence }
      message { Faker::Lorem.paragraph }
      notification_type { Faker::Lorem.word }
      is_read { false }
      user
    end
  end