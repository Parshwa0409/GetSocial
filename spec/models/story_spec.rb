require 'rails_helper'

RSpec.describe Story, type: :model do
  story_pic = FactoryBot.create(:story, :with_picture)
  
  it "has a pic attached" do 
    expect(story_pic.pic.attached?).to be(true) 
  end

  it "is valid" do
    expect(story_pic).to be_valid 
  end
end
