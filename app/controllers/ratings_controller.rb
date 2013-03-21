class RatingsController < ApplicationController
  # before_filter :signed_in_user

  def new
    @rating = Rating.new
  end

  def create
    @rating = current_user.ratings.build(params[:rating])
    @movie = Movie.find(params[:rating][:movie_id])
    if @rating.save
      flash[:success] = "Rating added!"
      redirect_to movie_path(@movie)
    else
      flash[:error] = "Problems occurred when trying to save rating"
    end
  end
end
