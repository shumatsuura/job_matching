class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :educations, dependent: :destroy
  accepts_nested_attributes_for :educations, allow_destroy: true

  has_many :languages, dependent: :destroy
  accepts_nested_attributes_for :languages, allow_destroy: true

  has_many :desired_industries, dependent: :destroy
  accepts_nested_attributes_for :desired_industries, allow_destroy: true
  has_many :industries, through: :desired_industries, source: :industry

  has_many :work_experiences, dependent: :destroy
  accepts_nested_attributes_for :work_experiences, allow_destroy: true

  has_many :user_skills, dependent: :destroy
  accepts_nested_attributes_for :user_skills, allow_destroy: true

  has_many :qualifications, dependent: :destroy
  accepts_nested_attributes_for :qualifications, allow_destroy: true

  has_many :desired_job_categories, dependent: :destroy
  accepts_nested_attributes_for :desired_job_categories, allow_destroy: true
  has_many :job_categories, through: :desired_job_categories, source: :job_category

  has_many :scouts, dependent: :destroy
  has_many :applies, dependent: :destroy

  has_many :follows, dependent: :destroy
  has_many :like_posts, dependent: :destroy

  mount_uploader :image, ImageUploader

end
