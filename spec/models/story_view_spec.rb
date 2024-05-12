require 'rails_helper'

RSpec.describe StoryView, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:story) { FactoryBot.create(:story, :with_picture) }

  it "is valid story view" do
    view = FactoryBot.build(:story_view, user: user, story: story)
    expect(view).to be_valid
  end
  
  it "is invalid for duplicate view" do
    # Create an initial view for the story by the user
    initial_view = FactoryBot.create(:story_view, user: user, story: story)
    
    # Attempt to create another view for the same story by the same user
    duplicate_view = FactoryBot.build(:story_view, user: user, story: story)
    
    expect(initial_view).to be_valid
    # Expect the duplicate view to be invalid
    expect(duplicate_view).not_to be_valid
    expect(duplicate_view.errors[:user_id]).to include("has already been taken")
  end
end
