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


end
