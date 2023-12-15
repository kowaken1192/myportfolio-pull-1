FactoryBot.define do
  factory :review do
    user
    post
    score { 2 }
    title { "最高でした"}
    content { "また行きたいです"}
    review_images { (Rails.root.join('spec/fixtures/test.jpg'))  }
  end
end
  
