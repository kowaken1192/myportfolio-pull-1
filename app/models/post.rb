class Post < ApplicationRecord
  validates :name , presence: true 
  validates :address , presence: true
  validates :country, presence: true
end
