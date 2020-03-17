class Company < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :company_applies, through: :posts, source: :applies

  has_many :company_skills, dependent: :destroy

  has_many :scouts, dependent: :destroy
  has_many :scouted_users, through: :scouts, source: :user

end
