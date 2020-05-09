# frozen_string_literal: true

FactoryBot.define do
  factory :airport do
    sequence(:icao) { |x| ('AAAA'..'ZZZZ').to_a[x] }
    name      { "#{Faker::Name.name} Airport" }
    city      { "#{Faker::Address.city} #{Faker::Address.country}" }
    latitude  { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
