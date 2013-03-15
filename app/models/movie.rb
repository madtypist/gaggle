class Movie < ActiveRecord::Base
  attr_accessible :desc, :title, :year, :movie_id

  validates :title, presence: true

  has_many :ratings
  has_many :users, :through => :ratings
end
