FactoryBot.define do 
  factory :post do
    user
    name { "東京ドーム" }
    address { "tokyo" }
    country { "japan" }
  end 
end
