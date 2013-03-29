class MoviesController < ApplicationController
  #Make sure the user is logged in before letting them do anything except view index and show
  before_filter :authenticate_user!, except: [:index, :show, :search]

  def show
    @movie = Movie.find(params[:id])
    if user_signed_in?
      if Rating.where(:user_id => current_user.id, :movie_id => @movie.id).empty?
        @rating = Rating.new(grade: 75)
      else
        @rating = Rating.where(:user_id => current_user.id, :movie_id => @movie.id).find(params[:id])
      end
    end
  end

  def search
    q = params[:movie][:title]
    @json = Movie.rt_search(q)
    @movies = Movie.db_search(q)
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
