# frozen_string_literal: true

FactoryBot.define do
  factory :pirep_status do
    sequence(:name) { |x| "PIREP Status #{x}" }
    sequence(:sequence) { |n| 20 + n }
  end
end
