require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /show" do
    let(:test_post) { FactoryBot.create(:post, :with_image) }
    let(:user) { FactoryBot.create(:user) }

    before(:each) do
      sign_in(user)
    end

    it "is successful request" do
      get post_path(test_post)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    let(:user) { FactoryBot.create(:user) }

    before(:each) do
      sign_in(user)
    end

    it "is successful request & render posts/new template" do
      get new_post_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template("posts/new")
    end
  end


  describe "POST /create" do
    let(:user) { FactoryBot.create(:user) }
    let(:test_post) { FactoryBot.create(:post, :with_image) }
  
    before(:each) do
      sign_in(user)
    end
  
    it "is not a successful request" do
      post posts_path
      expect(response).to_not have_http_status(:success)
    end
  
    it "is successful request with all valid params and redirects to posts/show page" do
      image = ActiveStorage::Blob.create_and_upload!(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'Bugatti.png'), 'rb'),
        filename: "Bugatti.png",
        content_type: 'image/png'
      )

      post posts_path(
        post: {
          caption: "Rspec - Test Post",
          image: image.signed_id
        }
      )

      expect(response.status).to be >= 300
      expect(response).to redirect_to(post_path(assigns(:post)))
    end

    it "is an unsuccessful request because it has no caption & redirects to root page" do
      image = ActiveStorage::Blob.create_and_upload!(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'Bugatti.png'), 'rb'),
        filename: "Bugatti.png",
        content_type: 'image/png'
      )
  
      post posts_path(
        post: {
          image: image.signed_id
        }
      )

      expect(assigns(:post).errors.full_messages).to include("Caption can't be blank")
      expect(response.status).to eq(302)
      expect(response).to redirect_to(root_path)
    end

    it "is an unsuccessful request because it has no image & redirects to root page" do
      post posts_path(
        post: {
          caption: "RSpec - Test Caption"
        }
      )

      expect(assigns(:post).errors.full_messages).to include("Post must have an iamge attachment.")
      expect(response.status).to eq(302)
      expect(response).to redirect_to(root_path)
    end
  end

  describe "PATCH /update" do 
    let(:test_post) { FactoryBot.create(:post, :with_image) }

    before(:each) do
      sign_in (test_post.user)
    end

    it "is not a successful request" do
      patch post_path(test_post)
      expect(response).to_not have_http_status(:success)
    end
  
    it "is successful request with all valid params and redirects to posts/show page" do
      patch post_path(
        test_post,
        post: {
          caption: "Rspec - Test Post",
        }
      )

      expect(response.status).to eq(302) 
      expect(response).to redirect_to(post_path(assigns(:post)))
      expect(assigns(:post).caption).to eq("Rspec - Test Post")
      expect(test_post.reload.caption).to eq("Rspec - Test Post")
    end

    it "is an unsuccessful request because it has no caption & renders posts/edit template" do
      image = ActiveStorage::Blob.create_and_upload!(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'Bugatti.png'), 'rb'),
        filename: "Bugatti.png",
        content_type: 'image/png'
      )

      patch post_path(
        id: test_post.id,
        post: {
          caption: nil, 
          image: image.signed_id
        }
      )      

      expect(assigns(:post).errors.full_messages).to include("Caption can't be blank") 
      expect(response).to render_template("posts/edit")
    end
  end


  describe "DELETE /destroy" do
    let(:test_post) {FactoryBot.create(:post, :with_image) }
    let(:user) { test_post.user }

    before(:each) do
      sign_in (user)
    end

    it "is successful request & redirect to profile-path of user" do
      delete post_path(test_post)
      expect(response).to redirect_to(profile_path(user))
    end
  end

  describe "POST /share" do
    let(:test_post) {FactoryBot.create(:post, :with_image) }
    let(:sender) { test_post.user }
    let(:reciever) { FactoryBot.create(:user) }

    before(:each) do
      sign_in sender
    end

    def unread_notification_count(user)
      user.notifications.where(type: "PostActivityNotifier::Notification").unread.count
    end

    it "successful & notifies the notifiers on new event" do
      expect(unread_notification_count(reciever)).to eq(0)
      
      post post_share_post_path(test_post, reciever)
      
      expect(unread_notification_count(reciever)).to eq(1)
    end
  end
end
