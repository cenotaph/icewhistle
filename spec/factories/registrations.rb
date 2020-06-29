FactoryBot.define do
  factory :registration do
    association :event
    name { Faker::Name.first_name }
    phone { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
    question1 { Faker::TvShows::BojackHorseman.quote }
    question2 { Faker::TvShows::BojackHorseman.quote }
    website { Faker::Internet.url }
  end
end

