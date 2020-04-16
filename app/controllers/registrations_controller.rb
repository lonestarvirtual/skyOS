# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  # rubocop:disable Rails/LexicallyScopedActionFilter
  prepend_before_action :check_captcha, only: [:create]
  # rubocop:enable Rails/LexicallyScopedActionFilter

  private

  # verify reCaptcha was valid
  #
  # rubocop:disable Style/GuardClause
  # rubocop:disable Metrics/MethodLength
  def check_captcha
    # return if recaptcha is not enabled
    return unless GoogleRecaptcha.enabled?

    self.resource = resource_class.new sign_up_params
    resource.validate # Look for any other validation errors besides reCAPTCHA

    success = verify_recaptcha(
      action: 'registration',
      model: resource,
      attribute: :recaptcha,
      minimum_score: 0.5,
      secret_key: GoogleRecaptcha::SECRET_KEY
    )

    unless success
      set_minimum_password_length
      respond_with_navigational(resource) { render :new }
    end
  end
  # rubocop:enable Style/GuardClause
  # rubocop:enable Metrics/MethodLength

  def sign_up_params
    params.require(:pilot).permit(:first_name,
                                  :last_name,
                                  :email,
                                  :password,
                                  :password_confirmation)
  end
end
