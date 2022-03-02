class Place < ApplicationRecord
  validates :name, :city, :state, presence: true
  validates :token, presence: true, length: { minimum: 10 }

  scope :by_token, ->(token) { where(token: token) }
  scope :search, ->(name) { where('LOWER(name) LIKE ?', "%#{name.downcase}%") if name.present? }
  scope :sorted_by_name, -> { order(:name) }
end
