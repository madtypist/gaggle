require "rottentomatoes"
include RottenTomatoes

class StaticPagesController < ApplicationController
  def home
    @recentlyrated = Rating.order("updated_at DESC").limit(6)
  end

  def help
  end

  def about
  end
end
