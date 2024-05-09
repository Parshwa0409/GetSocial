require 'rails_helper'

RSpec.describe "Comments", type: :request do
  # GET - /posts/:post_id/comments(.:format) comments#index
  describe "GET /index" do
    let(:user) { FactoryBot.create(:user) }

    # the user creating the comment can be different , need not be necessary the active-user
    let(:comment) { FactoryBot.create(:comment) }

    before(:each) do
      sign_in user
    end 

    it "is successful request" do 
      get post_comments_path(comment.post)

      expect(response).to have_http_status(:success)
    end

    it "renders the comments" do 
      get post_comments_path(comment.post)

      expect(response).to render_template("comments/_comments")
    end

    it "should return html content" do
      get post_comments_path(comment.post)

      expect(response.media_type).to eq("text/html")
    end

    it "get all the comments of the post" do 
      get post_comments_path(comment.post)
      
      post = assigns(:post)
      comments = assigns(:comments)
      
      expect(comments).to eq(post.comments)
    end
  end


  # POST - /posts/:post_id/comments(.:format) comments#create
  describe "POST /create" do
    let(:user) { FactoryBot.create(:user) }
    let(:test_post) { FactoryBot.create(:post) }

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

