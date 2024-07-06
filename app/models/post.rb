class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :title, :content, presence: true
  validates :genre_id, numericality: { other_than: 1 }

  belongs_to :genre
  belongs_to :user
  has_many :likes

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  scope :yesterday, -> { where(created_at: 1.day.ago.all_day) }
  scope :three_days_later, -> { where(created_at: 3.day.ago.all_day) }
  scope :seven_days_later, -> { where(created_at: 7.day.ago.all_day) }
end
