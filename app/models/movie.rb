class Movie < ActiveRecord::Base
  attr_accessible :desc, :title, :year

  validates :title, presence: true
end
