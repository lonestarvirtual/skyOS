# frozen_string_literal: true

FactoryBot.define do
  factory :fleet do
    association(:airline)
    association(:equipment)
  end
end
