class Review < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :score, presence: true
  mount_uploaders :review_images, ReviewImageUploader
  serialize :review_images, JSON
end
