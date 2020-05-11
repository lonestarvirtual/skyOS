# frozen_string_literal: true

FactoryBot.define do
  factory :simulator do
    sequence(:short_name) { |x| "SN#{x}" }
    sequence(:name) { |n| "Name #{n}" }

    trait :invalid do
      short_name { nil }
      name       { nil }
    end
  end
end
