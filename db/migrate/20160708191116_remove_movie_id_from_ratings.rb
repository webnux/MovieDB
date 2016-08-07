class RemoveMovieIdFromRatings < ActiveRecord::Migration
  def change
    remove_column :ratings, :movie_id, :integer
  end
end
