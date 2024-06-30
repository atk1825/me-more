class User < ApplicationRecord
 devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, :age, presence: true
  has_one :my_page
  has_many :posts
end
