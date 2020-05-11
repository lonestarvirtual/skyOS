# frozen_string_literal: true

module ControllerMacros
  def login_admin
    before(:each) do
      @current_pilot = FactoryBot.create(:pilot, :admin, :confirmed)
      sign_in @current_pilot
    end
  end

  def login_pilot
    before(:each) do
      @current_pilot = FactoryBot.create(:pilot, :confirmed)
      sign_in @current_pilot
    end
  end
end
