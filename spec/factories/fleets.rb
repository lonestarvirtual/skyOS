# frozen_string_literal: true

FactoryBot.define do
  factory :fleet do
    association(:airline)

    sequence(:icao) { |x| "IC#{x}" }
    sequence(:name) { |x| "Aircraft #{x}" }
    sequence(:short_name) { |x| "A#{x}" }
  end
end
