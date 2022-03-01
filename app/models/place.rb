class Place < ApplicationRecord
  validates :name, :city, :state, presence: true
  validates :token, presence: true, length: { minimum: 10 }

  scope :by_token, ->(token) { where(token: token) }
end
