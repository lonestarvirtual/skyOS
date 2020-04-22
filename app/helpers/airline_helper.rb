# frozen_string_literal: true

module AirlineHelper
  def airline_logo(airline)
    if airline.logo.attached?
      image_tag airline.logo.variant(resize_to_limit: [150, 25])
    else
      airline.name
    end
  end
end
