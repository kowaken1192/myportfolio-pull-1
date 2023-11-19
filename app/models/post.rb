class Post < ApplicationRecord
  validates :name , presence: true 
  validates :address , presence: true
  validates :country, presence: true
  has_many :reviews, dependent: :destroy 
  has_many :favorites, dependent: :destroy
  belongs_to :user
  mount_uploader :postimage, AvatarUploader
  scope :latest, -> { order(created_at: :desc) }
  scope :with_counts_and_avg_score, -> {
    select('posts.*, COUNT(DISTINCT reviews.id) as reviews_count, COUNT(DISTINCT favorites.id) as favorites_count, AVG(reviews.score) as average_score')
    .left_joins(:reviews, :favorites)
    .group('posts.id')
  }
  scope :reviews_count, -> { 
    left_joins(:reviews)
    .group(:id)
    .order('COUNT(reviews.id) DESC') 
  }
  scope :avg_score_and_review_count, -> {
    with_counts_and_avg_score
    .order('average_score DESC, reviews_count DESC')
  }

  def self.ransackable_attributes(auth_object = nil)
    ["detail", "name", "address","country"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    %w(reviews)
  end

  def avg_score
    if self[:average_score].present?
      self[:average_score].to_f.round(1) 
    else
      reviews.empty? ? 0.0 : reviews.average(:score).round(1).to_f
    end
  end
  
  def review_score_percentage
    (self.avg_score * 100 / 5).round(1)
  end  
end
