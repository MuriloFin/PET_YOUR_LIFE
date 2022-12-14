class User < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :adoptions, dependent: :destroy
  has_many :chatrooms
  has_many :likes
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :photo
end
