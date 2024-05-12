require 'rails_helper'

RSpec.describe Post, type: :model do
  it "is valid, with all the valid attributes" do 
    post = FactoryBot.build(:post, :with_image)
    expect(post).to be_valid
  end
  
  it "has image attached to it" do
    post = FactoryBot.build(:post, :with_image)
    expect(post.image.attached?).to be(true)
  end

  it "has no image attached to it" do
    post = FactoryBot.build(:post, :without_image)
    expect(post.image.attached?).to be(false)
  end

  it "is invalid because it has no caption" do
    post = FactoryBot.build(:post, :with_image, caption: nil)
    expect(post.valid?).to be(false)
  end

  it "is invalid because it has no image attached" do
    post = FactoryBot.build(:post, :without_image)
    expect(post).not_to be_valid
    expect(post.errors.full_messages).to include("Post must have an iamge attachment.")
  end
end
