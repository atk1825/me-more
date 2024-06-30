class User < ApplicationRecord
 devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :age, presence: true
  has_one :my_page
end
