class User < ApplicationRecord
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  # :confirmable, :trackable

  validates :user_name, presence: true, length: { maximum: 20, minimum: 6 }

  validates :email, presence: true, length: { maximum: 100 }

  has_many :appointments
end
