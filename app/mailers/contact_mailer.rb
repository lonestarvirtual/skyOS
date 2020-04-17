# frozen_string_literal: true

class ContactMailer < ApplicationMailer
  def contact_email(contact)
    @contact = contact
    subject = 'Website contact request'

    # Email each staff member
    #
    Setting.admin_emails.each do |address|
      mail(to: address, from: contact.email, subject: subject)
    end
  end
end
