# frozen_string_literal: true

FactoryBot.define do
  factory :announcement do
    title { Faker::Lorem.words(number: 4).join(' ') }
    body  { Faker::Lorem.paragraph }
    start_at { Time.current }
    end_at   { Time.current + 2.days }

    trait :invalid do
      title { nil }
      body  { nil }
    end

    trait :skip_validation do
      to_create { |instance| instance.save(validate: false) }
    end
  end
end
