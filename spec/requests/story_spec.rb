require 'rails_helper'

RSpec.describe "Storeries", type: :request do
  let(:test_user) { FactoryBot.create(:user) }
  let(:test_user_follower) { FactoryBot.create(:user) }
  
  before(:each) do
    sign_in(test_user_follower)

    test_user_follower.send_follow_request_to(test_user)
    test_user.accept_follow_request_of(test_user_follower)
  end

  describe "GET /index" do
    it "is successful request" do
      get stories_path
      expect(response).to have_http_status(:success)
    end

    it "gets all the stories of the users that current-user follows" do
      FactoryBot.create(:story, :with_picture, user: test_user)

      get stories_path
      expect(assigns(:stories)).to eq(test_user.stories)
    end
  end

  describe "POST /create" do
    let(:user) { FactoryBot.create(:user) }

    before(:each) do
      sign_in(user)
    end

    it "is a successful request & redirect to stories_path" do
      pic = ActiveStorage::Blob.create_and_upload!(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'Bugatti.png'), 'rb'),
        filename: "Bugatti.png",
        content_type: 'image/png'
      ) 
      
      post stories_path(
        story:{
          pic: pic.signed_id
        }
      )

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(story_path(assigns(:story)))
    end

    it "is not a successful request & redirect to profile_page with an error message " do
      post stories_path(
        story:{
          pic: nil
        }
      )

      expect(assigns(:story).errors.full_messages).to include("Story must have an iamge attachment.")
      expect(response).to redirect_to(profile_path(user))
    end
  end

  describe "GET /show" do
    let(:story) { FactoryBot.create(:story, :with_picture) }

    before(:each) do
      sign_in(story.user)
    end

    it "is a successful request & render stories/show" do
      get story_path(story)
      expect(response).to have_http_status(200)
      expect(response).to render_template("stories/show")
    end
  end

  describe "GET /my_stories" do
    let(:user) {FactoryBot.create(:user)}
    
    let(:stories) {
      [ 
        FactoryBot.create(:story, :with_picture, user: user), 
        FactoryBot.create(:story, :with_picture, user: user), 
        FactoryBot.create(:story, :with_picture, user: user),
        FactoryBot.create(:story, :with_picture, user: user) 
      ]
    }

    before(:each) do
      sign_in(user)
    end

    it "is a successful request" do
      get my_stories_stories_path
      
      expect(response).to have_http_status(200)
    end

    it "verifies my stories" do
      my_stories = stories

      get my_stories_stories_path

      expect(assigns(:stories)).to eq(user.stories)
      expect(assigns(:stories)).to eq(my_stories)
    end
  end
end
