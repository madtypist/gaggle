class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
  end

  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(params[:movie])
    @movie.save

    flash.notice = "Movie successfully added"

    redirect_to movie_path(@movie)
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update_attributes(params[:movie])

    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    title = @movie.title
    @movie.destroy

    flash.notice = "Movie #{title} deleted forever"

    redirect_to movies_path
  end
end
