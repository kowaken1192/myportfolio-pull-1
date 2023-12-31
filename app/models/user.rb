class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
  has_many :posts, dependent: :destroy
  mount_uploader :image, ImageUploader
  mount_uploader :background_image, BackgroundImageUploader  
  
  def already_favorited?(post)
    self.favorites.exists?(post_id:  post.id)
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.first_name = 'Guest'
      user.last_name = 'User'  
      user.is_valid = true
    end
  end

  def active_for_authentication?
    super && is_valid
  end
  
  def inactive_message
    is_valid ? super : :account_not_valid
  end
end
