# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
["Action", "Drama", "Horror", "Comedy", "Animated"].each do |category_name|
  Category.find_or_create_by(name: category_name)
end

action_category = Category.find_by(name: "Action")
["Departed", "Mad Max"].each do |movie_name|
  Movie.find_or_create_by(title: movie_name, category: action_category)
end

drama_category = Category.find_by(name: "Drama")
Movie.find_or_create_by(title: "The Godfather", category: drama_category)

horror_category = Category.find_by(name: "Horror")
["Conjuring", "Insidious", "Saw I", "Saw II", "Saw III"].each do |movie_name|
  Movie.find_or_create_by(title: movie_name, category: horror_category)
end

anime_category = Category.find_by(name: "Animated")
["Shrek 1", "The Godfather", "Madagascar I", "Shrek II"].each do |movie_name|
  Movie.find_or_create_by(title: movie_name, category: anime_category)
end

Movie.all.each do |movie|
  movie.update_attribute('description', "Description of movie #{movie.title}")
end

User.create(email: "testuser@test.com", password: "123456")
