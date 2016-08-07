class Movie < ActiveRecord::Base
  default_scope { joins(:category).order('categories.name ASC') }
  # has two attributes title and description
  belongs_to :category
  has_many :ratings, dependent: :destroy
  has_many :users, through: :ratings

  accepts_nested_attributes_for :category

  validates :title, uniqueness: true
  validates :title, presence: true

  def average_rating
    number_of_rating = ratings.count
    return "-" if number_of_rating.zero?
    total_rating = ratings.map(&:score).compact.sum
    ((total_rating / number_of_rating.to_f).to_f).round(2)
  end

  def has_ratings?(user)
    ratings.where(user: user)
  end

  def self.search(category_id, movie)
    searched_movies = []
    movie = movie.to_s.downcase
    if category_id.blank? && movie.blank?
      searched_movies = all
    elsif category_id.blank? && !movie.blank?
      searched_movies = where('lower(title) LIKE ?', "%#{movie}%")
    elsif !category_id.blank? && movie.blank?
      searched_movies = where(category_id: category_id)
    else
      searched_movies = where(category_id: category_id).where('lower(title) LIKE ?', "%#{movie}%")
    end
    searched_movies
  end

  def rating_for_user(current_user)
    ratings.where(user: current_user).first
  end
end
