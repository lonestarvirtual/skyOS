# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email      { Faker::Internet.email }

    message    { Faker::Lorem.paragraph }

    trait :invalid do
      first_name  { nil }
      last_name   { nil }
      email       { nil }
      message     { nil }
    end
  end
end
