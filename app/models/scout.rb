class Scout < ApplicationRecord
  belongs_to :user
  belongs_to :company

  has_many :scout_messages, dependent: :destroy
end
