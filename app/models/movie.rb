class Movie < ActiveRecord::Base
  attr_accessible :desc, :title, :year

  validates :title, presence: true

  has_many :ratings
  has_many :users, :through => :ratings
end
