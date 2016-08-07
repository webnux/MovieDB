require "rails_helper"

describe User, :type => :model do
  it "has many movies through ratings" do
    user = FactoryGirl.create(:user)
    first_movie = FactoryGirl.create(:movie)
    second_movie = FactoryGirl.create(:movie, title: "test1")
    FactoryGirl.create(:rating, user: user, movie: first_movie)
    FactoryGirl.create(:rating, user: user, movie: second_movie)
    expect(user.movies.count).to eq(2)
  end
end
