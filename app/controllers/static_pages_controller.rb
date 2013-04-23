require "rottentomatoes"
include RottenTomatoes

class StaticPagesController < ApplicationController
  def home
    @boxoffice = RottenList.find(:type => 'box_office')
    @boxoffice.each do |m|
      Movie.create_from_rt(m.id)
    end
  end

  def help
  end

  def about
  end
end
