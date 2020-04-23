# frozen_string_literal: true

FactoryBot.define do
  factory :simulator do
    sequence(:short_name) { |x| "SN#{x}" }
    sequence(:name) { |n| "Name #{n}" }
  end
end
