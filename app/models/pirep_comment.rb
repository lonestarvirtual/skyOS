# frozen_string_literal: true

class PirepComment < ApplicationRecord
  belongs_to :pirep, optional: false
  belongs_to :author, class_name: 'Pilot', optional: false

  validates :body, presence: true
  validates :body, presence: { allow_blank: false }
end
