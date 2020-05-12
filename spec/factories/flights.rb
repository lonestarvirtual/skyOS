# frozen_string_literal: true

FactoryBot.define do
  factory :flight do
    # Create a fleet for the equipment if the airline does not already have one
    after(:build) do |flight|
      airline   = flight.airline
      equipment = flight.equipment

      unless airline.fleets.collect(&:equipment).include? equipment
        create(:fleet, airline: flight.airline, equipment: flight.equipment)
      end
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
