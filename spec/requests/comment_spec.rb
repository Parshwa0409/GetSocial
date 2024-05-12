require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe "GET /index" do
    let(:user) { FactoryBot.create(:user) }
    let(:test_post) {FactoryBot.create(:post, :with_image)}

    before(:each) do
      sign_in user
      FactoryBot.create(:comment, post: test_post)
      FactoryBot.create(:comment, post: test_post)
      FactoryBot.create(:comment, post: test_post)
      FactoryBot.create(:comment, post: test_post)
    end 

    it "is successful request" do 
      get post_comments_path(test_post)
      expect(response).to have_http_status(:success)
    end

    it "renders the comments/_comments template" do 
      get post_comments_path(test_post)
      expect(response).to render_template("comments/_comments")
    end

    it "should return text/html content" do
      get post_comments_path(test_post)
      expect(response.media_type).to eq("text/html")
    end

    it "get all the comments of the post" do 
      get post_comments_path(test_post)
      expect(assigns(:comments).count).to eq(assigns(:post).comments.count)
    end
  end


  describe "POST /create" do
    let(:user) { FactoryBot.create(:user) }
    let(:test_post) {FactoryBot.create(:post, :with_image) }

    before(:each) do
      sign_in user
    end 

    it "is successful request" do 
      post post_comments_path(test_post, comment:{
          content: "Rspec - Test Comment"
        }
      )
      expect(response).to have_http_status(:success)
    end

    it "renders comment partial on an successful request" do 
      post post_comments_path(test_post, comment:{
          content: "Rspec - Test Comment"
        }
      )
      expect(response).to render_template("comments/_comment")
    end

    it "renders create_comment_error partial on an successful request" do 
      post post_comments_path(test_post, comment:{
          content: nil
        }
      )
      expect(response).to render_template("comments/_create_comment_error")
    end
  end
end

