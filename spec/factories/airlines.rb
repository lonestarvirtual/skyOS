# frozen_string_literal: true

FactoryBot.define do
  factory :airline do
    sequence(:icao, &:to_s)
    sequence(:iata, &:to_s)
    sequence(:name) { |n| "Airline #{n}" }
  end
end
