require "rails_helper"

describe Movie, :type => :model do
  it "has attributes title, description" do
    movie = FactoryGirl.create(:movie)
    movie.save
    expect(movie.title).to eq("My First Movie")
    expect(movie.description).to eq("This is my first description")
  end

  it "returns average rating" do
    movie = FactoryGirl.create(:movie)
    first_user = FactoryGirl.create(:user, email: "test1@test.com")
    second_user = FactoryGirl.create(:user, email: "test2@test.com")
    FactoryGirl.create(:rating, movie: movie, user: first_user, score: 5)
    FactoryGirl.create(:rating, movie: movie, user: second_user, score: 2)
    expect(movie.average_rating).to eq(3.5)
  end

  it "returns empty value when there is no rating" do
    movie = FactoryGirl.create(:movie)
    expect(movie.average_rating).to eq("-")
  end

  context "validates" do
    it "presence of title" do
      movie = Movie.new()
      movie.save
      errors = {:title => ["can't be blank"]}
      expect(movie.errors.messages).to eq(errors)
    end

    it "uniqueness of title" do
      movie = FactoryGirl.create(:movie, title: "Duplicate Movie")
      duplicate_movie = Movie.new(title: "Duplicate Movie")
      duplicate_movie.save
      errors = {:title => ["has already been taken"]}
      expect(duplicate_movie.errors.messages).to eq(errors)
    end
  end

  context "searches movies when " do
    it "no category or movie name is provided" do
      movie = FactoryGirl.create(:movie, title: "Searched Movie")
      result = Movie.search("", "")
      expect(result.first.title).to eq("Searched Movie")
    end

    it "category is provided but movie name is not provided" do
      first_category = FactoryGirl.create(:category, name: "search")
      second_category = FactoryGirl.create(:category, name: "search again")
      first_movie = FactoryGirl.create(:movie, category: first_category, title: "First")
      second_movie = FactoryGirl.create(:movie, category: second_category, title: "Second")
      result = Movie.search(first_category.id.to_s, "")

      expect(result.count).to eq(1)
      expect(result.first.title).to eq("First")
    end

    it "category is not provided but movie name is provided" do
      FactoryGirl.create(:movie, title: "First")
      FactoryGirl.create(:movie, title: "Second")
      result = Movie.search("", "Fi")

      expect(result.count).to eq(1)
      expect(result.first.title).to eq("First")
    end

    it "category and name both are provided" do
      first_category = FactoryGirl.create(:category, name: "First")
      second_category = FactoryGirl.create(:category, name: "Second")
      first_movie = FactoryGirl.create(:movie, category: first_category, title: "First Movie")
      first_movie = FactoryGirl.create(:movie, category: first_category, title: "Test")
      second_movie = FactoryGirl.create(:movie, category: second_category, title: "Second Movie")
      result = Movie.search(first_category.id.to_s, "First")

      expect(result.count).to eq(1)
      expect(result.first.title).to eq("First Movie")
    end
  end

  it "returns rating for user" do
    user = FactoryGirl.create(:user, email: "sadiksha@test.com")
    movie = FactoryGirl.create(:movie, title: "test")
    FactoryGirl.create(:rating, movie: movie, score: 1)
    rating = FactoryGirl.create(:rating, movie: movie, user: user, score: 5)
    result = movie.rating_for_user(user)

    expect(result.score).to eq(5)

  end
end
