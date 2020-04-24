# frozen_string_literal: true

FactoryBot.define do
  factory :pirep do
    association(:pilot)
    association(:airline, strategy: :create)
    association(:orig, strategy: :create, factory: :airport)
    association(:dest, strategy: :create, factory: :airport)
    association(:equipment, strategy: :create)
    association(:simulator, strategy: :create)
    association(:status, factory: :pirep_status, strategy: :create)

    sequence(:flight)
    sequence(:route) { |x| "ROUTE #{x}" }

    date { DateTime.now }
    leg  { rand(1..10) }
    duration { rand(0.1..99.9).round(1) }

    after(:build) do |pirep|
      create(:fleet, airline: pirep.airline, equipment: pirep.equipment)
    end
  end
end
