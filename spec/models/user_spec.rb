require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with all valid attributes" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end
  
  it "is not valid because of no email" do 
    user = FactoryBot.build(:user, email: nil)
    expect(user).to_not be_valid
  end

  it "is not valid because of invalid email" do 
    user = FactoryBot.build(:user, email: "email")
    expect(user).to_not be_valid
  end

  it "is not valid because of no password" do 
    user = FactoryBot.build(:user, password: nil)
    expect(user).to_not be_valid
  end

  it "is not valid because of invalid name" do 
    user = FactoryBot.build(:user, name: nil)
    expect(user).to_not be_valid
  end

  it "is not valid because of invalid password" do 
    user = FactoryBot.build(:user, password: "pass")
    expect(user).to_not be_valid
  end
end
