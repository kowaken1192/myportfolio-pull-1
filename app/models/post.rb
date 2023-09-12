class Post < ApplicationRecord
  validates :name , presence: true 
  validates :address , presence: true
  validates :country, presence: true
  has_many :reviews, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  def avg_score
    unless self.reviews.empty?
      reviews.average(:score).round(1).to_f
    else
      0.0
    end
  end

  def review_score_percentage
    unless self.reviews.empty?
      reviews.average(:score).round(1).to_f*100/5
    else
      0.0
    end
  end
end