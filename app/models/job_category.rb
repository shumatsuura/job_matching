class JobCategory < ApplicationRecord
  has_many :desired_job_categories, dependent: :destroy

  # h = (1..JobCategory.count).to_a.map { |n| [JobCategory.find(n).name.to_sym,n] }.to_h
  # enum job_category_id: h
end
