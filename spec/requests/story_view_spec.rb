require 'rails_helper'

RSpec.describe "StoryViews", type: :request do
  describe "POST /create" do
    let(:user) { FactoryBot.create(:user) }
    let(:story) { FactoryBot.create(:story, :with_picture) }

    before(:each) do
      sign_in(user)
    end

    it "is a successful request & create add view to story (it's being viewed by user for first time)" do
      expect {
        post story_views_path(story_id: story.id)
      }.to change { story.reload.views }.by(1)
    end

    it "is a successful request & create add view to story (it's already viewed by user )" do
      FactoryBot.create(:story_view, story: story, user: user)

      expect {
        post story_views_path(story_id: story.id)
      }.to change { story.reload.views }.by(0)
    end
  end
end
