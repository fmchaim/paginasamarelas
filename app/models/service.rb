class Service < ApplicationRecord
  belongs_to :user
  has_many :contracts
  validates :category, presence: true
end
