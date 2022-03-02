# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  # NOTE: `default` is unusable for dynamic variables due to Rails eager loading
  # in production. See `after_action` for dynamically set headers used by skyOS
  #
  # default from: Setting.reply_to,
  #         'X-skyOS-Organization': Setting.organization_name

  layout 'mailer'
  add_template_helper(EmailHelper)

  after_action do
    mail.from(Setting.reply_to) if mail.from.blank?
    mail.subject.prepend("[#{Setting.organization_name}] ")
    mail['X-skyOS-Org'] = Setting.organization_name
  end
end
