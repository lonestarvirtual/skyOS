# frozen_string_literal: true

class Permission < ApplicationRecord
  has_many :group_permissions, dependent: :destroy
  has_many :groups, through: :group_permissions

  validates :model, :action, :description, presence: true
end
