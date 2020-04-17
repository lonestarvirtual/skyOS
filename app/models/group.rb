# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :group_permissions, dependent: :destroy
  has_many :permissions, through: :group_permissions
  has_many :pilots, dependent: :restrict_with_error

  before_validation :capitalize_name

  validates :name, :description, presence: true, uniqueness: true

  private

  def capitalize_name
    self.name = name.capitalize unless name.nil?
  end
end
