class Review < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :score, presence: { score: "口コミ評価をしてください" }
end
