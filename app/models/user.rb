class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable

  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  validates :username, presence: true, length: { maximum: 20, minimum: 6 }
  validates :email, presence: true, length: { maximum: 100 }

  #   devise :database_authenticatable, :registerable,
  #       # :recoverable, :rememberable, :trackable, :validatable

  # + validates :username, uniqueness: { case_sensitive: false }, presence: true,
  #             allow_blank: false, format: { with: /\A[a-zA-Z0-9]+\z/ }

  #   has_many :appointments

  # def generate_jwt
  #   JWT.encode({ id: id,
  #               exp: 60.days.from_now.to_i },
  #              Rails.application.secrets.secret_key_base)
  # end
end
