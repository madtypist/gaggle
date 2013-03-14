require 'spec_helper'

describe Movie do
  before {
    @movie = Movie.new(title: "Greatest Movie Ever", desc:"Very cool movie", year: 2013)
  }

  subject { @movie }

  it { should respond_to(:title) }
  it { should respond_to(:desc) }
  it { should respond_to(:year) }
  it { should respond_to(:ratings) }

  #note - how do I come back and change this to reviewers instead of users?
  it { should respond_to(:users) }

  it { should be_valid }

  describe "when title is not present" do
    before { @movie.title = " " }
    it { should_not be_valid }
  end
end
