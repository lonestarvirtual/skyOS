# frozen_string_literal: true

module ApplicationHelper
  def active_class(path)
    'active' if current_page? path
  end

  def admin_link_to(name, model, options = nil, html_options = {})
    return unless current_pilot.can? model, %i[create update destroy]

    link_to name, options, html_options
  end

  # Return a copyright string like "2018-2020" or just "YYYY" if
  # "YYYY" is the current year
  #
  def copyright_years
    if Time.zone.now.year == Setting.copyright_year
      return Setting.copyright_year
    end

    "#{Setting.copyright_year}-#{Time.current.year}"
  end
end
