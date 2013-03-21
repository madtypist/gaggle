class RatingsController < ApplicationController
  # before_filter :signed_in_user

  def new
    @rating = Rating.new
  end

  def create
    @rating = current_user.ratings.build(params[:rating])
    @movie = Movie.find(params[:rating][:movie_id])
    if @rating.save
      flash[:notice] = "Rating added!"
      redirect_to movie_path(@movie)
    else
      flash[:notice] = "Problems occurred when trying to save rating"
    end
  end

  def update
    @rating = Rating.find(params[:id])
    @rating.update_attributes(params[:rating])

    @movie = Movie.find(params[:rating][:movie_id])
    if @rating.save
      flash[:success] = "Rating updated!"
      redirect_to movie_path(@movie)
    else
      flash[:error] = "Problems occurred when trying to save rating"
    end
  end
end
