class Review < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :score, presence: { message: "スコアを入力してください" }
end
