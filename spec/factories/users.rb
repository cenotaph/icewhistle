# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Name.first_name }
    name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { 'test_password' }
    trait :confirmed do
      after(:create, &:confirm)
    end
  end
end
