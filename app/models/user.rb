class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  devise :database_authenticatable,
  :jwt_authenticatable, :registerable, jwt_revocation_strategy: JwtDenylist
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  # :confirmable, :trackable

  validates :username, presence: true, length: { maximum: 20, minimum: 6 }

  validates :email, presence: true, length: { maximum: 100 }

  has_many :appointments
end
