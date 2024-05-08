require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}", remove this to add your own test-code

  it "can run tests" do
    expect(false).to be(false)
  end

  it "is valid with valid attributes" do
    user = FactoryBot.create(:user)
    
    expect(user).to be_valid
  end
  
  it "is not valid because of no email" do 
    user = FactoryBot.create(:user)
    user.email = nil
    
    expect(user).to_not be_valid
  end

  it "is not valid because of invalid email" do 
    user = FactoryBot.create(:user)
    user.email = "test email"
    
    expect(user).to_not be_valid
  end

  it "is not valid because of invalid name" do 
    user = FactoryBot.create(:user)
    user.name = nil

    expect(user).to_not be_valid
  end

  it "is not valid because of no password" do 
    user = FactoryBot.create(:user)
    user.password = nil

    expect(user).to_not be_valid
  end

  it "is not valid because of invalid password" do 
    user = FactoryBot.create(:user)
    user.password = "nil"

    expect(user).to_not be_valid
  end

end
