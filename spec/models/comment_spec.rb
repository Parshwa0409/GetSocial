require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:post) { FactoryBot.create(:post, :with_image) }
  it "is valid with all the valid attributes" do
    comment = FactoryBot.build(:comment, post: post)
    expect(comment).to be_valid
  end

  it "is invalid because the comment has not content" do
    comment = FactoryBot.build(:comment, post: post, content: nil)
    expect(comment).to_not be_valid
    expect(comment.errors.full_messages.to_sentence).to include("Cannot post an empty comment 😒")

  end
end
