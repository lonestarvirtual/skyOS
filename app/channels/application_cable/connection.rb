# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      # assignment during this condition is by design
      # rubocop:disable Lint/AssignmentInCondition
      if verified_user = env['warden'].user
        # rubocop:enable Lint/AssignmentInCondition
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
