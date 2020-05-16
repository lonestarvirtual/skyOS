# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Notifications', type: :request do
  login_pilot

  describe 'DELETE #destroy' do
    before :each do
      @notification = create(:notification, pilot: @current_pilot)
    end

    it 'destroys the notification' do
      expect do
        delete notification_path(@notification)
      end.to change(Notification, :count).by(-1)
    end

    it '"all" destroys all notifications' do
      create_list(:notification, 9, pilot: @current_pilot)
      expect do
        delete notification_path('all')
      end.to change(Notification, :count).by(-10)
    end

    # TODO: Fix this test on @notifications.destroy_all
    # using destroy all never returns false even if there is an error
    # it 'redirects to the root path if the notification cannot be destroyed' do
    #   expect_any_instance_of(Notification).to receive(:destroy).and_return(false)
    #   delete notification_path(@notification)
    #   expect(response).to redirect_to root_path
    # end
  end
end
