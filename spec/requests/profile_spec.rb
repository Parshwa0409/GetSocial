require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  describe "GET /show" do
    let(:user) { FactoryBot.create(:user) }

    before(:each) do
      sign_in user
    end

    it "is a successful request" do
      get profile_path(user)
      expect(response).to have_http_status(:success)
    end

    it "displays all the posts of the user & verifying the count here" do
     FactoryBot.create(:post, :with_image, user: user)
      get profile_path(user)
      expect(assigns(:posts).count).to eq(user.posts.count)
    end
  end

  describe "PATCH /update" do
    let(:user) { FactoryBot.create(:user) }

    before(:each) do
      sign_in user
    end

    it "is not a successful request" do
      patch profile_path(user, nil)
      expect(response).to_not have_http_status(:success)
    end

    it "is not a successful request and has errors" do
      patch profile_path(user, user:{
        name: nil,
        email:  nil,
        bio:  nil,
        profile_picture:  nil ,
        cover_photo:  nil 
      })
      expect(assigns(:user).errors.full_messages).to eq(["Name cannot be empty.", "Email must be of valid format", "Email can't be blank"])
    end

    it "is not a successful request invalid name and has name error" do
      patch profile_path(user, user:{
        name: nil,
        email: Faker::Internet.email ,
        bio: Faker::Quote.yoda ,
        profile_picture:  nil ,
        cover_photo:  nil 
      })
      expect(assigns(:user).errors.full_messages).to include("Name cannot be empty.")
    end

    it "is not a successful request no email and has name error" do
      patch profile_path(user, user:{
        name: "Parshwa",
        email: nil ,
        bio: Faker::Quote.yoda ,
        profile_picture:  nil ,
        cover_photo:  nil 
      })
      expect(assigns(:user).errors.full_messages).to include("Email can't be blank")
    end

    it "is not a successful request invalid email and has name error" do
      patch profile_path(user, user:{
        name: "Parshwa",
        email: "abcd" ,
        bio: Faker::Quote.yoda ,
        profile_picture:  nil ,
        cover_photo:  nil 
      })
      expect(assigns(:user).errors.full_messages).to include("Email must be of valid format")
    end

    it "is a successful request with all the valid parameters & rediect to profile page" do
      patch profile_path(user, user:{
        name:  Faker::Name.name ,
        email:  Faker::Internet.email ,
        bio:  Faker::Quote.yoda ,
        profile_picture:  nil ,
        cover_photo:  nil 
      })
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(profile_path(user))
    end
  end
end
