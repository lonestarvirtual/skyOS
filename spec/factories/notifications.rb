# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    association :pilot
    title { Faker::Lorem.sentence }
    body  { Faker::Lorem.paragraph }
  end
end
