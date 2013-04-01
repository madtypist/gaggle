# encoding: utf-8

class Movie < ActiveRecord::Base
  attr_accessible :summary, :title, :year, :movie_id, :rt_id, :imdb_id, :poster_location

  validates :title, presence: true
  default_scope :order => 'title ASC'

  has_many :ratings
  has_many :users, :through => :ratings

  def self.rt_search(query)
    # Search Rotten Tomatoes for titles matching the query string. If they aren't in the database, add them
    uri = URI('http://api.rottentomatoes.com/api/public/v1.0/movies.json')
    rt_params = { :apikey => "#{ENV['ROTTEN_TOMATOES_KEY']}", :q => query }
    uri.query = URI.encode_www_form(rt_params)

    res = Net::HTTP.get_response(uri)
    json = JSON.parse res.body

    json["movies"].each do |m|
      #Why this conditional? Well, for whatever reason, my anecdotal exploration of the Rotten Tomatoes API suggests that a score of -1 is usually attached to something terrible/incredibly niche (and therefore not worth rating)
      if m["ratings"]["critics_score"] != -1
        Movie.where(rt_id: m["id"]).first_or_create(summary: m["synopsis"], title: m["title"], year: m["year"], poster_location: m["posters"]["detailed"])
      end
    end
  end

  def self.db_search(query)
    rt_search(query)
    movies = Movie.where("title LIKE?", "%#{query}%")
    movies
  end

  def avg_rating

  end

end
