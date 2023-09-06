class Review < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :score, presence: true
end
