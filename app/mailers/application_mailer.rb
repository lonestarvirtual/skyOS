# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV['STAFF_EMAIL'],
          'X-skyOS-Organization': 'Lonestar Virtual'

  layout 'mailer'
  add_template_helper(EmailHelper)

  after_action do
    mail.subject.prepend('[Lonestar Cargo] ')
  end
end
