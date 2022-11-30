class Activity < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :bookings
  has_many :reviews
end
