class Rating < ActiveRecord::Base
  attr_accessible :grade, :opinion, :recommended, :movie_id
  validates :user_id, presence: true
  validates_numericality_of :grade, :less_than_or_equal_to => 100, :greater_than_or_equal_to => 0, :only_integer => true

  belongs_to :user
  belongs_to :movie
end
