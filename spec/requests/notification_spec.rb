require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  describe "post /mark_all_pan_as_read" do
    let(:sender) { FactoryBot.create(:user) }
    let(:reciever) { FactoryBot.create(:user) }
    let(:record) { FactoryBot.create(:post) }
    let(:post_path) { "/notifications/mark_all_pan_as_read" }

    before(:each) do
      sign_in reciever
    end 

    def unread_notificatio_count
      reciever.notifications.where(type: "PostActivityNotifier::Notification").unread.count
    end

    it "is a successful request" do
      post post_path
      expect(response).to have_http_status(:success)
    end

    
    it "must read all the notifications" do
      Notifier::PostActivity.notify(
        "has shared a post.", 
        false, 
        record, 
        sender.email, 
        reciever
      )
      expect(unread_notificatio_count).to eq(1)
      
      post post_path
      
      expect(unread_notificatio_count).to eq(0)
    end
  end

  describe "post /mark_all_dm_as_read" do
    let(:sender) { FactoryBot.create(:user) }
    let(:reciever) { FactoryBot.create(:user) }
    let(:record) { FactoryBot.create(:message, sender: sender, recipient: reciever ) }
    let(:post_path) { "/notifications/mark_all_dm_as_read" }

    before(:each) do
      sign_in reciever
    end 

    def unread_notificatio_count
      reciever.notifications.where(type: "MessageNotifier::Notification").unread.count
    end

    it "is a successful request" do
      post post_path
      expect(response).to have_http_status(:success)
    end

    
    it "must read all the notifications" do
      Notifier::Message.notify(
        record, 
        record.msg,
        false
      )
      expect(unread_notificatio_count).to eq(1)
      
      post post_path
      
      expect(unread_notificatio_count).to eq(0)
    end
  end
end
