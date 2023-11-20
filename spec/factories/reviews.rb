FactoryBot.define do
  factory :review do
    user
    post
    score { 2 }
  end
end
