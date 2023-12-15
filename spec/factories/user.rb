FactoryBot.define do 
  factory :user do
    first_name { "nakai" }
    last_name  { "tarou" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { "dottle-nouveau-pavilion-tights-furze" }
    password_confirmation { "dottle-nouveau-pavilion-tights-furze" }
  end 
end
