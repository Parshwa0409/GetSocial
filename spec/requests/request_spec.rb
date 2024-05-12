require 'rails_helper'

RSpec.describe "Requests", type: :request do
  describe "POST /follow" do
    let(:user_1) { FactoryBot.create(:user) }
    let(:user_2) { FactoryBot.create(:user) }
    
    it "sends follow request to user" do
      sign_in(user_1)
      post follow_path(user_2)
      expect(user_1.sent_follow_request_to?(user_2)).to be(true)
    end
  end

  describe "POST /unfollow" do
    let(:user_1) { FactoryBot.create(:user) }
    let(:user_2) { FactoryBot.create(:user) }

    it "allows user to unfollow another user" do
      user_1.send_follow_request_to(user_2) 
      user_2.accept_follow_request_of(user_1)
      
      sign_in(user_1)

      post unfollow_path(user_2)
      expect(user_1.following?(user_2)).to be(false)
    end
  end

  describe "POST /accept" do
    let(:user_1) { FactoryBot.create(:user) }
    let(:user_2) { FactoryBot.create(:user) }

    it "allows user to accept follow request from another user" do
      user_1.send_follow_request_to(user_2)

      sign_in(user_2)

      post accept_path(user_1)
      expect(user_1.following?(user_2)).to be(true)
    end
  end

  describe "POST /decline" do
    let(:user_1) { FactoryBot.create(:user) }
    let(:user_2) { FactoryBot.create(:user) }

    it "allows user to decline follow request from another user" do
      user_1.send_follow_request_to(user_2)
      sign_in(user_2)
      post decline_path(user_1)
      expect(user_1.following?(user_2)).to be(false)
    end
  end

  describe "POST /block" do
    let(:user_1) { FactoryBot.create(:user) }
    let(:user_2) { FactoryBot.create(:user) }

    it "allows user to block another user" do
      sign_in(user_1)
      post block_path(user_2)
      expect(user_1.blocked?(user_2)).to be(true)
    end
  end

  describe "POST /unblock" do
    let(:user_1) { FactoryBot.create(:user) }
    let(:user_2) { FactoryBot.create(:user) }

    it "allows user to unblock another user" do
      user_1.block(user_2)
      sign_in(user_1)
      post unblock_path(user_2)
      expect(user_1.blocked?(user_2)).to be(false)
    end
  end
end