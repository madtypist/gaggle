require 'spec_helper'

describe Rating do
  let (:user) { FactoryGirl.create(:user) }
  let (:movie) { FactoryGirl.create(:movie) }

  before {
    @rating = user.ratings.build(opinion: "some thoughts", recommended: true, grade: 90, movie_id: movie.id)
  }

  subject { @rating }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @rating.user_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Rating.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "relationships" do
    it { should respond_to(:user) }
    it { should respond_to(:movie) }
    its(:user) { should == user }
    its(:movie) { should == movie }
  end

end
