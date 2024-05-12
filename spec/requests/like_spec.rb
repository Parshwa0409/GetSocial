require 'rails_helper'

RSpec.describe "Likes", type: :request do

  # likes POST - /likes(.:format) - likes#create
  describe "POST /create" do
    let(:user) { FactoryBot.create(:user) }
    let(:test_post) {FactoryBot.create(:post, :with_image) }

    before(:each) do
      sign_in user
    end 

    it "is a successful request" do
      post likes_path(id: test_post.id)
      expect(response).to have_http_status(:success)
    end

    it "increases the post_total_likes count by 1 if succesful" do
      expect { post likes_path(id: test_post.id) }.to change { test_post.reload.total_likes }.by(1)
    end
  end

  # like DELETE - /likes/:id(.:format) - likes#destroy
  describe "DELETE /destroy" do
    let(:user) { FactoryBot.create(:user) }
    let(:test_post) {FactoryBot.create(:post, :with_image) }
    let(:likes_delete_path) {"/likes/#{test_post.id}"}

    before(:each) do
      sign_in user
    end 

    it "is a successful request" do
      delete likes_delete_path
      expect(response).to have_http_status(:success)
    end

    it "reduces the post_total_likes count by 1 if successful" do
      FactoryBot.create(:like, user: user, post: test_post)
      expect { delete likes_delete_path }.to change { test_post.reload.total_likes }.by(-1)
    end
  end
end
