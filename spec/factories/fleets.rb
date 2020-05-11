# frozen_string_literal: true

FactoryBot.define do
  factory :fleet do
    association(:airline)
    association(:equipment)

    trait :invalid do
      airline { nil }
      equipment { nil }
    end
  end
end
