class Service < ApplicationRecord
  belongs_to :user
  has_many :contracts
  validates :category, presence: true
  has_one_attached :photo
end
