require 'spec_helper'

describe Rating do
  let (:user) { FactoryGirl.create(:user) }

  before {
    @rating = user.ratings.build(opinion: "some thoughts", recommended: true, grade: 90)
  }

  subject { @rating }

  describe "when user_id is not present" do
    before { @rating.user_id = nil }
    it { should_not be_valid }
  end
end
