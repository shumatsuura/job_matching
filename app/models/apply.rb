class Apply < ApplicationRecord
  belongs_to :user
  belongs_to :post
  delegate :company, to: :post

  has_many :apply_messages, dependent: :destroy
  enum status: {Unchecked: 0, "Under Selection": 1, Rejected: 2, Offered: 3}
end
