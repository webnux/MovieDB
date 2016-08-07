class CreateJoinTableMoviesRatings < ActiveRecord::Migration
  def change
    create_join_table :movies, :ratings do |t|
      t.index [:movie_id, :rating_id]
      t.index [:rating_id, :movie_id]
    end
  end
end
