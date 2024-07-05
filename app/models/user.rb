class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, :age, presence: true

  has_many :posts
  has_many :likes
  has_one_attached :image
end
