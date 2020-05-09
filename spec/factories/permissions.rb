# frozen_string_literal: true

FactoryBot.define do
  factory :permission do
    sequence(:model) { |m| "model #{m}" }
    sequence(:action) { |m| "action #{m}" }
    sequence(:description) { |d| "description #{d}" }
  end
end
