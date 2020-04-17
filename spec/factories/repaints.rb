# frozen_string_literal: true

FactoryBot.define do
  factory :repaint do
    association(:fleet)
    sequence(:name) { |n| "Repaint #{n}" }

    after(:build) do |repaint|
      test_file = Rails.root.join('README.md')
      repaint.file.attach(io: File.open(test_file), filename: 'test.md', content_type: 'text')
    end
  end
end
