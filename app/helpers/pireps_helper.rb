# frozen_string_literal: true

module PirepsHelper
  def pirep_display_audit(pirep)
    status = pirep.status
    return status.name if status.editable? || pirep.versions.empty?

    audit = pirep.versions.last
    timef = '%m-%d-%Y %H:%M %Z'
    "#{status.name} by #{audit.version_author}" \
    " at #{audit.created_at.strftime(timef)}"
  end
end
