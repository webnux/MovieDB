require "rails_helper"

describe Rating, :type => :model do
  it "has attributes score" do
    rating = FactoryGirl.create(:rating)
    expect(rating.score).to eq(1)
  end

  it "belongs to user and movie" do
    rating = FactoryGirl.create(:rating)
    user = rating.user
    movie = rating.movie
    expect(user.email).to eq("test@test.com")
    expect(movie.title).to eq("My First Movie")
  end

  context "checks if the rating already exists for user and movie" do
    it "when there is movie and no rating" do
      user = create(:user)
      movie = create(:movie)
      result = Rating.exists_for_user_and_movie?(movie, user)
      expect(result).to be nil
    end

    it "when there is rating for a movie" do
      rating = create(:rating)
      movie = rating.movie
      user = rating.user
      result = Rating.exists_for_user_and_movie?(movie, user)
    end
  end

  it "cannot have same user and movie multiple times" do
    rating = create(:rating)
    user = rating.user
    movie = rating.movie
    new_rating = Rating.new(user: user, movie: movie)
    new_rating.save
    error_message = new_rating.errors.messages.values.flatten.first
    expect(error_message).to eq("can't be created twice for same user and movie.")
  end

  it "can be different for different users for single movie" do
    rating = create(:rating)
    second_user = create(:user, email: "testuser@test.com")
    second_rating = FactoryGirl.create(:rating, user: second_user, movie: rating.movie)
    error_messages = []
    expect(error_messages).to be_empty
  end

  it "can be different for different movies and same user" do
    rating = create(:rating)
    movie = create(:movie, title: "Second movie")
    rating = FactoryGirl.create(:rating, user: rating.user, movie: movie)
    error_messages = []
    expect(error_messages).to be_empty
  end

  context "score" do
    it "can be between 1 and 5" do
      rating = FactoryGirl.create(:rating, score: 3)
      result = rating.score
      expect(result).to be(3)
    end

    it "cannot be more than 5" do
      user = FactoryGirl.create(:user)
      movie = FactoryGirl.create(:movie)
      rating = Rating.new(score: 7, user: user, movie: movie)
      rating.save
      error_message = {:score => ["is not included in the list"]}

      expect(rating.errors.messages).to eq(error_message)
    end
  end

  it "should have user and a movie" do
    rating = Rating.new(score: 2)
    rating.save
    error_message = {:movie => ["can't be blank"],
                     :user => ["can't be blank"]}
    expect(rating.errors.messages).to eq(error_message)
  end
end
