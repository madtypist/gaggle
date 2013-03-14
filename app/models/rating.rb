class Rating < ActiveRecord::Base
  attr_accessible :grade, :opinion, :recommended
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :movie
end
