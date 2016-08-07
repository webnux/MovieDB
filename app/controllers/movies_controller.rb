class MoviesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    relevant_movies = Movie.search(params[:category], params[:movie])
    @movies = relevant_movies.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.create(movie_params)
    redirect_to movies_path
  end

  def show
    @movie = Movie.find(params[:id])
    @rating = Rating.find_or_initialize_by(user: current_user, movie: @movie)
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update_attributes(movie_params)
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :category_id)
  end
end
