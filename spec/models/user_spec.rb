require 'spec_helper'

describe User do
  
  it "should create a new instance if attributes are valid" do
    user = Factory.create(:user)
  end

  it "should validate email" do
    user = Factory.build(:user, email: 'wrong_email')
    user.should_not be_valid
  end

  it "should validate username" do
    user = Factory.build(:user, username: 'puff@mail.ru')
    user.should_not be_valid
  end

  it "should validate password" do
    user = Factory.build(:user, password: 'bad')
    user.should_not be_valid
  end

  it "should reject user with nonmatching passwords" do
    user = Factory.build(:user, password: 'secret', password_confirmation: 'babushka')
    user.should_not be_valid
  end

  it "should be created with auth_token" do
    user = Factory.create(:user)
    user.auth_token.should_not be_nil
  end

end