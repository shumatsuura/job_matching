class PostSkill < ApplicationRecord
  belongs_to :post
  belongs_to :company_skill
end
