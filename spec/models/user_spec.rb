require 'spec_helper'

describe User do
  before {
    @user = User.new(:username => "testuser", :email => "something@fake.com", :password => "password", :password_confirmation => "password")
  }

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:email) }

  it { should be_valid }

  describe "when name isn't present" do
    before { @user.username = "" }
    it { should_not be_valid }
  end

  describe "when email isn't present" do
    before { @user.email = "" }
    it { should_not be_valid }
  end
end
