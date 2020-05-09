# frozen_string_literal: true

FactoryBot.define do
  factory :group_permission do
    association(:group)
    association(:permission)
  end
end
