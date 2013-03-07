class Rating < ActiveRecord::Base
  attr_accessible :grade, :movie_id, :opinion, :recommended, :user_id
end
