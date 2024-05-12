require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, :with_image) }

  it "is valid post like" do
    like = FactoryBot.build(:like, user: user, post: post)
    expect(like).to be_valid
  end
  
  it "is invalid for duplicate like" do
    # Create an initial like for the post by the user
    initial_like = FactoryBot.create(:like, user: user, post: post)
    
    # Attempt to create another like for the same post by the same user
    duplicate_like = FactoryBot.build(:like, user: user, post: post)
    
    expect(initial_like).to be_valid
    # Expect the duplicate like to be invalid
    expect(duplicate_like).not_to be_valid
    expect(duplicate_like.errors[:user_id]).to include("has already been taken")
  end
end
