require 'rails_helper'

RSpec.describe "NotificationPreferences", type: :request do
  describe "POST /create" do
    let(:preferred_user) { FactoryBot.create(:user) }
    let(:preferred_notifier) { FactoryBot.create(:user) }

    before(:each) do
      sign_in preferred_notifier
    end 

    it "is a successful request" do
      post notification_preferences_path(
        {id: preferred_user.id}
      )
      expect(response).to have_http_status(:success)
    end

    it "renders success_partial on success" do
      post notification_preferences_path(
        {id: preferred_user.id}
      )
      expect(response).to render_template("shared/_success")
    end

    it "renders error message on failure" do
      post notification_preferences_path()
      expect(response).to render_template("shared/_danger")
    end
  end

  describe "DELETE /destroy" do
    let(:preferred_user) { FactoryBot.create(:user) }
    let(:preferred_notifier) { FactoryBot.create(:user) }

    before(:each) do
      sign_in preferred_notifier
    end 

    it "is a successful request & unsubscribe from users post notification" do
      np = FactoryBot.create(
        :notification_preference, 
        preferred_user: preferred_user, 
        preferred_notifier: preferred_notifier
      ) 

      # debugger
      
      delete notification_preference_path(
        {id: preferred_user.id}
      )
      
      expect(assigns(:preference)).to eq(np)
      expect(assigns(:preference).present?).to eq(true)
      expect(response).to have_http_status(:success)
    end

    it "is an unsuccessful request & renders shared/danger partial" do
      delete notification_preference_path(
        {id: preferred_user.id}
      )
      
      expect(response).to have_http_status(:success)
      expect(response).to render_template("shared/_danger")

    end
  end
end
