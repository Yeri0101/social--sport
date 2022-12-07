class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  scope :all_except, ->(user) { where.not(id: user) }

  has_one_attached :avatar

  has_many :activities, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :address, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :country_code, presence: false
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: false
  validates :postcode, presence: true
  validates :state, presence: true

  # enum status: %i[offline away online]

  # after_commit :add_default_avatar, on: %i[create update]
  # after_create_commit { broadcast_append_to 'users' }
  # after_update_commit { broadcast_update }

  # def avatar_thumbnail
  #   avatar.variant(resize_to_limit: [150, 150]).processed
  # end

  # def chat_avatar
  #   avatar.variant(resize_to_limit: [50, 50]).processed
  # end

  # def broadcast_update
  #   broadcast_replace_to 'user_status', partial: 'users/status', user: self
  # end

  # def status_to_css
  #   case status
  #   when 'online'
  #     'bg-success'
  #   when 'away'
  #     'bg-warning'
  #   when 'offline'
  #     'bg-dark'
  #   else
  #     'bg-gray'
  #   end
  # end

  # private

  # def add_default_avatar
  #   return if avatar.attached?

  #   avatar.attach(
  #     io: File.open(Rails.root.join('app', 'assets', 'images', 'default_profile.png')),
  #     filename: 'default_profile.png',
  #     content_type: 'image/png'
  #   )
  # end
end
