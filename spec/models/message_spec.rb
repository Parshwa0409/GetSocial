require 'rails_helper'

RSpec.describe Message, type: :model do
  it "is valid with all valid attributes" do
    message = FactoryBot.build(:message, :with_attachment)
    expect(message).to be_valid
  end

  it "is invalid because it has no msg" do
    message = FactoryBot.build(:message, :with_attachment, msg: nil)
    expect(message).to_not be_valid
    expect(message.errors.full_messages).to include("Msg cannot be empty 😒")
  end

  it "has an attachment attached to it & is valid message" do
    message = FactoryBot.build(:message, :with_attachment)
    expect(message).to be_valid
    expect(message.attachment.attached?).to be(true)
  end

  it "has no attachment attached to it & is valid message" do
    message = FactoryBot.build(:message, :without_attachment)
    expect(message).to be_valid
    expect(message.attachment.attached?).to be(false)
  end

end
