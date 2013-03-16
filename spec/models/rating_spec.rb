require 'spec_helper'

describe Rating do
  let (:user) { FactoryGirl.create(:user) }
  let (:movie) { FactoryGirl.create(:movie) }

  before {
    @rating = user.ratings.build(opinion: "some thoughts", recommended: true, grade: 90, movie_id: movie.id)
  }

  subject { @rating }

  it { should be_valid }
  it { should respond_to(:grade) }
  it { should respond_to(:opinion) }
  it { should respond_to(:recommended) }

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

  describe "grade values should not be greater than 100" do
    before { @rating.grade = 101 }
    it { should_not be_valid }
  end

  describe "grade values should not be less than 0" do
    before { @rating.grade = -1 }
    it { should_not be_valid }
  end

  describe "grade values should be an integer" do
    before { @rating.grade = 76.45 }
    it { should_not be_valid }
  end

end
