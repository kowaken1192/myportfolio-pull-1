FactoryBot.define do
  factory :review do
    user
    post
    score { 2 }
    review_images { (Rails.root.join('spec/fixtures/test.jpg'))  }
  end
end
  
