require 'spec_helper'

describe Rating do
  let (:user) { FactoryGirl.create(:user) }

  before {
    @rating = user.ratings.build(opinion: "some thoughts", recommended: true, grade: 90)
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

    it "should not allow access to movie_id" do
      expect do
        Rating.new(movie_id: 1)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end

  end

end
