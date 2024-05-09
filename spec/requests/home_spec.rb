require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /index" do
    let(:user) { FactoryBot.create(:user) }

    before(:each) do
      sign_in user
    end 

    it "is a successful request" do
      get root_path
      expect(response).to have_http_status(:success)
    end

    it "renders to home/index page" do
      get root_path
      expect(response).to render_template("home/index")
    end
  end
end
