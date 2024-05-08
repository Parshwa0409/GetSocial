require 'rails_helper'

RSpec.describe Post, type: :model do
  post = FactoryBot.create(:post)
  
  it "is valid, with all the valid attributes" do 
    expect(post).to be_valid
  end

  it "is invalid because of no caption" do
    post.caption = nil
    expect(post.valid?).to be(false)
  end

  it "is invalid because of no image" do
    post.image.purge
    expect(post.valid?).to be(false)
  end
end
