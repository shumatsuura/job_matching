class Education < ApplicationRecord
  belongs_to :user
  validates :school_name, presence: true
  validates :period_start, presence: true
end
