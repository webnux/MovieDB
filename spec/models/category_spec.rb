require "rails_helper"

describe Category, :type => :model do
  it "has attribute name" do
    category = FactoryGirl.create(:category)
    category.save
    expect(category.name).to eq("Category")
  end

  it "has many movies" do
    category = FactoryGirl.create(:category, name: "Comedy")
    FactoryGirl.create(:movie, category: category)
    FactoryGirl.create(:movie, category: category, title: "Second movie")
    expect(category.movies.count).to eq(2)
    Movie.all.each do |movie|
      expect(movie.category.name).to eq("Comedy")
    end
  end
end
