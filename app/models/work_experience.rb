class WorkExperience < ApplicationRecord
  validates :company, presence: true 
  belongs_to :user
end
