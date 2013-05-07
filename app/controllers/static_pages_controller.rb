require "rottentomatoes"
include RottenTomatoes

class StaticPagesController < ApplicationController
  def home
    Rotten.api_key = ENV['ROTTEN_TOMATOES_KEY']
    @boxoffice = []
    boxoffice = RottenList.find(:type => 'box_office')
    boxoffice.each do |m|
      m = Movie.create_from_rt(m.id)
      @boxoffice << m
    end

    @recentlyrated = Rating.order("updated_at DESC").limit(5)

  end

  def help
  end

  def about
  end
end
