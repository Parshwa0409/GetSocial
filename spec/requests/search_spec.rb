require 'rails_helper'

RSpec.describe "Searches", type: :request do
  describe "GET /search" do
    let(:user) { FactoryBot.create(:user) }

    before(:each) do
      sign_in(user)
    end

    it "is successful request" do
      get search_path
      expect(response.media_type).to eq("text/html")
    end
  end

  describe "POST /query" do
    let(:user) { FactoryBot.create(:user) }

    before(:each) do
      sign_in(user)
    end

    it "is successful request & renders search/users template" do
      FactoryBot.create(:user, email: "parshwapatil9@gmail.com")
      FactoryBot.create(:user, name: "Parshwa")

      post search_path(search: {
        name: "Parshwa",
        email: "parshwapatil9@gmail.com"
      })

      expect(assigns(:users).count).to eq(2)
      expect(response).to render_template("search/_users")
    end

    it "is successful request & renders search/users template when searched by name only" do
      FactoryBot.create(:user, name: "Test User")

      post search_path(search: {
        name: "Test User"
      })

      expect(assigns(:users).count).to eq(1)
      expect(response).to render_template("search/_users")
    end

    it "is successful request & renders search/users template when searched by email only" do

      FactoryBot.create(:user, email: "TestUser@getsocial.in")

      post search_path(search: {
        email: "TestUser@getsocial.in"
      })

      expect(assigns(:users).count).to eq(1)
      expect(response).to render_template("search/_users")
    end
  end
end
