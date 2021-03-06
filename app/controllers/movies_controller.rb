class MoviesController < ApplicationController
  #Make sure the user is logged in before letting them do anything except view index and show
  before_filter :authenticate_user!, except: [:index, :show, :search]

  def show
    @movie = Movie.find(params[:id])
    if user_signed_in?
      if Rating.where(:user_id => current_user.id, :movie_id => @movie.id).empty?
        @rating = Rating.new(grade: 75) #the javascript slider doesn't work without a value in the form
      else
        @rating = Rating.where(:user_id => current_user.id, :movie_id => @movie.id).first
      end
    end
    # For the individual movie pages we should pull the Rotten Tomatoes info on the fly so that the user gets the most up-to-date info available
    @rotteninfo = Movie.rt_lookup(@movie.rt_id)
  end

  def search
    q = params[:movie][:title]
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
