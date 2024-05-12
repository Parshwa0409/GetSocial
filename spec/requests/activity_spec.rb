require 'rails_helper'

RSpec.describe "Activities", type: :request do
  describe "GET /index" do
    let(:user) { FactoryBot.create(:user) }

    before(:each) do
      sign_in user
    end 

    it "gets the activities/index page" do
      get activities_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template("activities/index")
    end

    it "gets the follow requests count" do 
      get activities_path
      frc = user.follow_requests.count
      expect(assigns(:follow_requests_count)).to eq(frc)
    end

    it "gets the pending requests count" do 
      get activities_path
      prc = user.pending_requests.count
      expect(assigns(:pending_requests_count)).to eq(prc)
    end

    it "gets all the post activity notifications" do 
      get activities_path
      pan = user.notifications.newest_first.where(type: "PostActivityNotifier::Notification")
      expect(assigns(:post_activity_notifications)).to eq(pan)
    end
  end
end
