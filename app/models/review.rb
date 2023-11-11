class Review < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :score, presence: { message: "評価をしてください" }
  mount_uploaders :review_images, ReviewImageUploader
  serialize :review_images, JSON
end
