FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }
    role { :farmer }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    contact_number { Faker::PhoneNumber.phone_number }
    address { Faker::Address.full_address }
  end
end
