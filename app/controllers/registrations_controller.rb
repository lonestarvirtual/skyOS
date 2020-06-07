# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  # rubocop:disable Rails/LexicallyScopedActionFilter
  prepend_before_action :check_captcha, only: [:create]
  before_action :check_new_registration_allowed?, only: [:create]
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
      minimum_score: GoogleRecaptcha.minimum_score,
      secret_key: GoogleRecaptcha.secret_key
    )

    unless success
      set_minimum_password_length
      respond_with_navigational(resource) { render :new }
    end
  end
  # rubocop:enable Style/GuardClause
  # rubocop:enable Metrics/MethodLength

  # Ensures that new signup is allowed before processing
  # the registration or redirects back to the join page
  #
  def check_new_registration_allowed?
    return true if Setting.allow_signup?

    redirect_to root_path
    flash[:alert] = 'New pilot registration is currently disabled'
  end

  def sign_up_params
    params.require(:pilot).permit(:first_name,
                                  :last_name,
                                  :email,
                                  :password,
                                  :password_confirmation)
  end
end
