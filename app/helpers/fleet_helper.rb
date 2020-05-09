# frozen_string_literal: true

module FleetHelper
  def fleet_image(fleet, size: [150, 25])
    return unless fleet.image.attached?

    image_tag fleet.image.variant(resize_to_limit: size)
  end
end
