require 'rails_helper'

RSpec.describe Story, type: :model do
  story_with_pic = FactoryBot.build(:story, :with_picture)
  story_without_pic = FactoryBot.build(:story, :without_picture)

  it "is valid with all valid attributes" do
    expect(story_with_pic).to be_valid 
  end
  it "has a pic attached" do 
    expect(story_with_pic.pic.attached?).to be(true) 
  end

  it "it not valid because it has no pic attached" do
    expect(story_without_pic).to_not be_valid 
  end

  it "it has no pic attached" do
    expect(story_without_pic.pic.attached?).to be(false) 
    expect(story_without_pic.errors.full_messages).to include("Story must have an iamge attachment.")
  end
end
