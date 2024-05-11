require 'rails_helper'

RSpec.describe "NotificationPreferences", type: :request do
  describe "POST /create" do
    let(:preferred_user) { FactoryBot.create(:user) }
    let(:preferred_notifier) { FactoryBot.create(:user) }

    before(:each) do
      sign_in preferred_notifier
    end 

    it " is successful request" do
      post notification_preferences_path(
        {id: preferred_user.id}
      )
      expect(response).to have_http_status(:success)
    end

    it " renders success_partial on success" do
      post notification_preferences_path(
        {id: preferred_user.id}
      )

      expect(response).to render_template("shared/_success")
    end

    it " renders error message on failure" do
      post notification_preferences_path()

      expect(response).to render_template("shared/_danger")
    end
  end

  describe "DELETE /destroy" do
    let(:preferred_user) { FactoryBot.create(:user) }
    let(:preferred_notifier) { FactoryBot.create(:user) }
    let(:notification_preferences_path) {
      "/notification_preferences/#{preferred_user.id}"
    }
    before(:each) do
      sign_in preferred_notifier
    end 

    it "is a successful request" do
      delete notification_preferences_path

      expect(response).to have_http_status(:success)
    end
    # TODO: HOW TO VERIFY THIS
  end
end
