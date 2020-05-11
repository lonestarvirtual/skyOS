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

    trait :approved do
      status { PirepStatus.find_by(approved: true) }
    end

    trait :draft do
      status { PirepStatus.find_by(editable: true) }
    end

    trait :invalid do
      date     { nil }
      number   { nil }
      leg      { nil }
      duration { nil }
    end

    trait :submitted do
      status { PirepStatus.find_by(pending: true) }
    end
  end
end
