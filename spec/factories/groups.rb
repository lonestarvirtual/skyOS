# frozen_string_literal: true

FactoryBot.define do
  factory :group do
    sequence(:name) { |n| "Group #{n}" }
    sequence(:description) { |d| "Description #{d}" }
  end
end
