# frozen_string_literal: true

FactoryBot.define do
  factory :network do
    sequence(:name) { |n| "Network #{n}" }

    trait :invalid do
      name { nil }
    end
  end
end
