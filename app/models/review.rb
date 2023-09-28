class Review < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :score, presence: { score: "口コミ評価をしてください" }
  mount_uploaders :review_image, ReviewImageUploader
  serialize :image, JSON
end
