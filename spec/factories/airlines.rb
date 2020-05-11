# frozen_string_literal: true

FactoryBot.define do
  factory :airline do
    sequence(:icao) { |i| ('AAA'..'ZZZ').to_a[i] }
    sequence(:name) { |n| "Airline #{n}" }

    iata { ('AA'..'ZZ').to_a.sample }
  end

  trait :invalid do
    icao { nil }
    iata { nil }
    name { nil }
  end
end
