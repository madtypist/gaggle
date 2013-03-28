class Movie < ActiveRecord::Base
  attr_accessible :summary, :title, :year, :movie_id, :rt_id, :imdb_id, :poster_location

  validates :title, presence: true

  has_many :ratings
  has_many :users, :through => :ratings

  def self.rt_search(query)
    uri = URI('http://api.rottentomatoes.com/api/public/v1.0/movies.json')
    rt_params = { :apikey => "#{ENV['ROTTEN_TOMATOES_KEY']}", :q => query }
    uri.query = URI.encode_www_form(rt_params)

    res = Net::HTTP.get_response(uri)
    json = JSON.parse res.body

    json
  end

  def self.db_search(query)
    Movie.where("title LIKE?", "%#{query}%")
  end

end
