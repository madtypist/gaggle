require "rottentomatoes"
include RottenTomatoes

class StaticPagesController < ApplicationController
  def home
    @recentlyrated = Rating.order("updated_at DESC").limit(5)
  end

  def help
  end

  def about
  end
end
