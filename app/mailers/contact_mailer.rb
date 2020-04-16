# frozen_string_literal: true

class ContactMailer < ApplicationMailer
  def contact_email(contact)
    @contact = contact
    subject = 'Website contact request'
    mail(to: ENV['STAFF_EMAIL'], from: contact.email, subject: subject)
  end
end
