# frozen_string_literal: true

module PirepsHelper
  def pirep_display_audit(pirep)
    status = pirep.status
    return status.name if status.editable? || pirep.audits.empty?

    audit = pirep.audits.last
    timef = '%m-%d-%Y %H:%M %Z'
    "#{status.name} by #{audit.user} at #{audit.created_at.strftime(timef)}"
  end
end
