class Post < ApplicationRecord
  belongs_to :company

  has_many :post_industries, dependent: :destroy
  accepts_nested_attributes_for :post_industries

  has_many :post_job_categories, dependent: :destroy
  accepts_nested_attributes_for :post_job_categories

  has_many :post_skills, dependent: :destroy
  accepts_nested_attributes_for :post_skills
  has_many :skills, through: :post_skills, source: :company_skill

  has_many :applies, dependent: :destroy
  has_many :apply_messages, through: :applies, source: :apply_messages

end
