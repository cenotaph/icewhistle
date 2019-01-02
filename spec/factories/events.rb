FactoryBot.define do
  factory :event do
    name { Faker::TheThickOfIt.department }
    location { Faker::LordOfTheRings.location }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    description { Faker::Lebowski.quote }
    start_at  { Time.now + 2.weeks } 
    end_at { Time.now + 2.weeks + 3.hours } 
    link1 { Faker::Internet.url }
    registration { true }
  end
end

