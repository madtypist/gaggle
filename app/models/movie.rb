class Movie < ActiveRecord::Base
  attr_accessible :summary, :title, :year, :movie_id, :rt_id, :imdb_id, :poster_location

  validates :title, presence: true

  has_many :ratings
  has_many :users, :through => :ratings
end
