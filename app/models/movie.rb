# encoding: utf-8

class Movie < ActiveRecord::Base
  attr_accessible :summary, :title, :year, :movie_id, :rt_id, :imdb_id, :poster_location

  validates :title, presence: true

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
      # if m["alternate_ids"]["imdb"]
      #   imdb_id = m["alternate_ids"]["imdb"]
      # else
      #   imdb_id = ""
      # end
      if m["ratings"]["critics_score"] != -1
        Movie.where(rt_id: m["id"]).first_or_create(summary: m["synopsis"], title: m["title"], year: m["year"], poster_location: m["posters"]["detailed"])
      end
    end

    json
  end

  def self.db_search(query)
    movies = Movie.where("title LIKE?", "%#{query}%")
    movies
  end

end
