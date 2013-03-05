require 'spec_helper'

describe User do
  before {
    @user = User.new(:username => "testuser", :email => "something@fake.com", :password => "password", :password_confirmation => "password")
  }

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:email) }

  it { should be_valid }
end
