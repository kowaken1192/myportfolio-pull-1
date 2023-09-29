class Review < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :score, presence: { score: "口コミ評価をしてください" }
  mount_uploaders :review_images, ReviewImageUploader
  serialize :review_images, JSON
end
