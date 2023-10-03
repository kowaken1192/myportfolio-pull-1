class Post < ApplicationRecord
  validates :name , presence: true 
  validates :address , presence: true
  validates :country, presence: true
  has_many :reviews, dependent: :destroy 
  has_many :favorites, dependent: :destroy
  belongs_to :user
  mount_uploader :postimage, AvatarUploader
  scope :latest, -> { order(created_at: :desc) }
  
  scope :with_counts, -> {
    select('posts.*, COUNT(DISTINCT reviews.id) as reviews_count, COUNT(DISTINCT favorites.id) as favorites_count')
    .left_joins(:reviews, :favorites)
    .group('posts.id')
  }
  scope :reviews_count, -> { 
    left_joins(:reviews)
    .group(:id)
    .order('COUNT(reviews.id) DESC') 
  }

  scope :avg_score_and_review_count, -> {
    select('posts.*, AVG(reviews.score) as average_score, COUNT(reviews.id) as review_count')
    .joins(:reviews)
    .group('posts.id')
    .order('average_score DESC, review_count DESC')
  }
  scope :with_avg_score, -> {
    select('posts.*, AVG(reviews.score) as average_score')
    .left_joins(:reviews)
    .group('posts.id')
  }
    
  def self.ransackable_attributes(auth_object = nil)
    ["detail", "name", "address","country"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    %w(reviews)
  end

  def avg_score
    self[:average_score] || reviews.empty? ? 0.0 : reviews.average(:score).round(1).to_f
  end

  def review_score_percentage
    self.avg_score * 100 / 5
  end
end
