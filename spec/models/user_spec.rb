require 'spec_helper'

describe User do
  before {
    @user = FactoryGirl.create(:user)
  }

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:ratings) }
  it { should respond_to(:movies) }

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
