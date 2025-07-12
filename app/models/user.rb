class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy

    has_one_attached :image

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
end
