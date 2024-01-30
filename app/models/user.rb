class User < ApplicationRecord
  has_many :services
  has_many :contracts
end
