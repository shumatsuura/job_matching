class PostSkill < ApplicationRecord
  belongs_to :post
  belongs_to :company_skill
  validates :post_id, uniqueness: { scope: :company_skill_id }
end
