# encoding: utf-8

# I guess we need to include these to use the methods
require "rottentomatoes"
include RottenTomatoes

class Movie < ActiveRecord::Base
  attr_accessible :summary, :title, :year, :movie_id, :rt_id, :imdb_id, :poster_location

  validates :title, presence: true
  default_scope :order => 'title ASC'

  has_many :ratings
  has_many :users, :through => :ratings

  def self.create_from_rt(rotten_id)
    Rotten.api_key = ENV['ROTTEN_TOMATOES_KEY']
    m = RottenMovie.find(:id => rotten_id)
    movie = Movie.where(rt_id: rotten_id).first_or_create(summary: m.synopsis, title: m.title, year: m.year, poster_location: m.posters.detailed)
    movie
  end

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
    #To DO
  end

  def self.rt_lookup(rotten_id)
    Rotten.api_key = ENV['ROTTEN_TOMATOES_KEY']
    m = RottenMovie.find(:id => rotten_id)
    m
  end

  def self.get_recent_rentals
    #Hey! Let's get our recent rentals from Rotten Tomatoes, m'kay?
    Rotten.api_key = ENV['ROTTEN_TOMATOES_KEY']
    Rails.cache.fetch("recent_rentals", :expires_in => 10.minutes) do
      rentals = []
      results = RottenList.find(:type => 'new_releases')
      results.each do |m|
        m = Movie.create_from_rt(m.id)
        rentals << m
      end
      rentals
    end
  end

  def self.get_box_office
    Rotten.api_key = ENV['ROTTEN_TOMATOES_KEY']
    Rails.cache.fetch("boxoffice", :expires_in => 10.minutes) do
      boxoffice = []
      results = RottenList.find(:type => 'box_office')
      results.each do |m|
        m = Movie.create_from_rt(m.id)
        boxoffice << m
      end
      boxoffice
    end
  end
end
