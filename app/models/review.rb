class Review < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :review, presence: true
  
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_many :review_categories
  has_many :categories, through: :review_categories
  
  def favorited_by?(user)
   favorites.where(user_id: user.id).exists?
  end
  
  def split_id_from_youtube_url
  media_url.split('/').last if media_url.present?
  end
  
end
