# frozen_string_literal: true

class ContactsController < ApplicationController
  prepend_before_action :check_captcha, only: [:create]

  def create
    @contact = Contact.new(contact_params)

    if @contact.valid?
      ContactMailer.contact_email(@contact).deliver
      redirect_to root_path, notice: 'Your message has been sent!'
    else
      render :new
    end
  end

  def new
    @contact = Contact.new
    return unless pilot_signed_in?

    # Pre-fill contact form with logged in user details
    @contact.first_name = current_pilot.first_name
    @contact.last_name = current_pilot.last_name
    @contact.email = current_pilot.email
  end

  private

  # verify reCaptcha was valid
  #
  # rubocop:disable Metrics/MethodLength
  def check_captcha
    # return if recaptcha is not enabled
    return unless GoogleRecaptcha.enabled?

    @contact = Contact.new(contact_params)
    @contact.valid? # Look for any other validation errors besides reCAPTCHA

    success = verify_recaptcha(
      action: 'contact',
      model: @contact,
      attribute: :recaptcha,
      minimum_score: 0.5,
      secret_key: GoogleRecaptcha::SECRET_KEY
    )

    render :new unless success
  end
  # rubocop:enable Metrics/MethodLength

  def contact_params
    attr = params.require(:contact).permit(
      :first_name, :last_name, :email, :message
    )

    return attr unless pilot_signed_in?

    attr = params.require(:contact).permit(:message)
    attr[:first_name] = current_pilot.first_name
    attr[:last_name]  = current_pilot.last_name
    attr[:email]      = current_pilot.email

    attr
  end
end
