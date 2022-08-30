class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes, class_name: 'Recipe', foreign_key: :creator_id
  has_many :comments

  validates :first_name, length: { maximum: 15 }
end
