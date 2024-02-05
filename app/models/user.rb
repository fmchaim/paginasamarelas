class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :services, dependent: :destroy
  has_many :contracts
  has_one_attached :photo

  validates :email, uniqueness: true
  has_many :conversations, foreign_key: :sender_id
end
