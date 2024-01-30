class Contract < ApplicationRecord
  belongs_to :user
  belongs_to :service
  has_one :review
end
