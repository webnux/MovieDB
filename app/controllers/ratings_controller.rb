class RatingsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :show, :update]

  respond_to :json

  def create
    @movie = Movie.find(params[:rating][:movie_id])
    score = params[:rating][:score]
    @rating = @movie.ratings.build(user: current_user, score: score)

    respond_to do |format|
      format.json do
        @rating.save
        render json: { rating: @rating }
      end
    end
  end

  def show
    @rating = Rating.find(params[:id])

    respond_to do |format|
      format.json {
        render json: { rating: @rating }
      }
    end
  end

  def update
    @rating = Rating.find(params[:id])
    @rating.update_attribute('score', params[:rating][:score])

    respond_to do |format|
      format.json {
        render json: { rating: @rating }
      }
    end
  end
end
