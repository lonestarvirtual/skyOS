# frozen_string_literal: true

FactoryBot.define do
  factory :pirep_comment do
    association(:pirep)
    association :author, strategy: :create, factory: :pilot

    sequence(:body) { |x| "Comment #{x}" }
  end
end
