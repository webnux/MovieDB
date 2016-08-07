class DropJoinTableForMovieAndRating < ActiveRecord::Migration
  def change
    drop_join_table :movies, :ratings
  end
end
