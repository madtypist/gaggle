class Rating < ActiveRecord::Base
  attr_accessible :grade, :movie_id, :opinion, :recommended, :user_id
  validates :user_id, presence: true

  belongs_to :user
end
