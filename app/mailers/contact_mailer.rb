class ContactMailer < ApplicationMailer

  def contact_email(contact)
    @contact = contact
    subject = "Website contact request"
    mail(to: 'contactmailer@example.com', from: contact.email, subject: subject)
  end

end
