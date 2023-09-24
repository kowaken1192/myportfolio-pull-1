class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reviews, dependent: :destroy
  has_many :favorites
  has_many :favorite_posts, through: :favorites, source: :post
  has_many :posts
  mount_uploader :image, AvatarUploader
  mount_uploader :background_image, AvatarUploader

  def already_favorited?(post)
    self.favorites.exists?(post_id:  post.id)
  end
end
