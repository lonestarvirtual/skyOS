# frozen_string_literal: true

module ApplicationHelper
  def active_class(path)
    'active' if current_page? path
  end

  # Return a copyright string like "2018-2020" or just "YYYY" if
  # "YYYY" is the current year
  #
  def copyright_years
    if Time.zone.now.year == Setting.copyright_year
      return Setting.copyright_year
    end

    "#{Setting.copyright_year}-#{Time.zone.now.strftime('%Y')}"
  end
end
