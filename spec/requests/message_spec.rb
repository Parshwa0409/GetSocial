require 'rails_helper'

RSpec.describe "Messages", type: :request do
  describe "GET /index" do
    let(:user) { FactoryBot.create(:user) }

    before(:each) do
      sign_in user
    end 

    it "is successful request" do 
      get messages_path
      expect(response).to have_http_status(:success)
    end

    it "render messages/index page" do 
      get messages_path
      expect(response).to render_template("messages/index")
    end
  end

  describe "POST /create" do
    let(:sender) { FactoryBot.create(:user) }
    let(:recipient) { FactoryBot.create(:user) }

    before(:each) do
      sign_in sender
    end 

    it "is redirecting to recipients profile on success" do
      post messages_path(message:{
        msg: "Rspec - Test Message",
        attachment: nil,
        recipient_id: recipient.id,
        sender_id: sender.id
      })
      expect(response).to redirect_to(profile_path(recipient.id))
    end

    it "redirects to recipients profile on failure" do
      post messages_path(message:{
        msg: nil,
        attachment: nil,
        recipient_id: recipient.id,
        sender_id: sender.id
      })
      expect(response).to redirect_to(profile_path(recipient.id))
    end

    it "has an error on empty message" do
      post messages_path(message:{
        msg: nil,
        attachment: nil,
        recipient_id: recipient.id,
        sender_id: sender.id
      })
      expect(assigns(:message).errors.full_messages).to include("Msg cannot be empty 😒")
    end
  end
end
