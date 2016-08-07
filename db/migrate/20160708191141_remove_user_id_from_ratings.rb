class RemoveUserIdFromRatings < ActiveRecord::Migration
  def change
    remove_column :ratings, :user_id, :integer
  end
end
