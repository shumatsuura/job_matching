class Company < ApplicationRecord
  validates :name, presence: true, on: :update
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :company_applies, through: :posts, source: :applies

  has_many :industry_relations, dependent: :destroy
  accepts_nested_attributes_for :industry_relations, allow_destroy: true
  has_many :industries, through: :industry_relations, source: :industry

  has_many :company_skills, dependent: :destroy

  has_many :scouts, dependent: :destroy
  has_many :scouted_users, through: :scouts, source: :user

  has_many :follows, dependent: :destroy

  has_many :like_users, dependent: :destroy

  mount_uploader :logo, ImageUploader
  mount_uploader :header_image, HeaderUploader

end
