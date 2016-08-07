FactoryGirl.define do
  factory :rating do
    score 1
    movie
    user
  end
end
