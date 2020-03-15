class PostJobCategory < ApplicationRecord
  belongs_to :post
  belongs_to :job_category
end
