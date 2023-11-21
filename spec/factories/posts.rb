FactoryBot.define do 
  factory :post do
    user
    name { "東京ドーム" }
    address { "tokyo" }
    country { "japan" }
    postimage { (Rails.root.join('spec/fixtures/test.jpeg'))  }
  end 
end
