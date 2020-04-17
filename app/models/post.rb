class Post < ApplicationRecord
  enum status:{Open: 0, Closed: 1}
  belongs_to :company

  has_many :post_industries, dependent: :destroy
  accepts_nested_attributes_for :post_industries
  has_many :industries, through: :post_industries, source: :industry

  has_many :post_job_categories, dependent: :destroy
  accepts_nested_attributes_for :post_job_categories
  has_many :job_categories, through: :post_job_categories, source: :job_category

  has_many :post_skills, dependent: :destroy
  accepts_nested_attributes_for :post_skills
  has_many :skills, through: :post_skills, source: :company_skill

  has_many :applies, dependent: :destroy
  has_many :apply_messages, through: :applies, source: :apply_messages

  has_many :like_posts, dependent: :destroy

end
