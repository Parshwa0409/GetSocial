require 'rails_helper'

RSpec.describe Story, type: :model do
  story_pic = FactoryBot.create(:story, :with_picture)
  

  it "has a pic attached" do 
    expect(story_pic.pic.attached?).to be(true) 
  end

  it "is valid" do
    expect(story_pic).to be_valid 
  end

  # Test case to create story with out image and check if valid or not
  # Test case to check if the record without a picture is not saved
  # it "does not get saved" do
  #   story_no_pic = FactoryBot.create(:story, :without_picture)
  #   expect(story_no_pic.save).to eq(false)
  #   # expect(story_no_pic.persisted?).to be(false)
  # end
end
