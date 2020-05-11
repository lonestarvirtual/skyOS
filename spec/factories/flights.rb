# frozen_string_literal: true

FactoryBot.define do
  factory :flight do
    after(:build) do |flight|
      create(:fleet, airline: flight.airline, equipment: flight.equipment)
    end

    association :airline,   strategy: :create
    association :equipment, strategy: :create
    association :orig,      strategy: :create, factory: :airport
    association :dest,      strategy: :create, factory: :airport

    sequence(:number)
    leg { rand(1..9) }
    out_time { Time.zone.now }
    in_time  { Time.zone.now + rand(1.5..12).hours }

    trait :invalid do
      airline { nil }
      number { nil }
      leg { nil }
    end
  end
end
