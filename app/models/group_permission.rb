# frozen_string_literal: true

class GroupPermission < ApplicationRecord
  belongs_to :group,      optional: false
  belongs_to :permission, optional: false
end
