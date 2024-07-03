class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :genre
  belongs_to :user
  has_many :likes
  validates :title, :content, presence: true
  validates :genre_id, numericality: { other_than: 1 }
  def liked_by?(user)
    likes.where(user_id: user.id).exists? 
  end
end
