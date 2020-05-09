# frozen_string_literal: true

module EmailHelper
  def email_image_tag(image, **options)
    logo_img = "#{Rails.root}/app/assets/images/#{image}"
    attachments.inline['logo.png'] = File.read(logo_img)
    image_tag attachments['logo.png'].url, **options
  end
end
