class Apply < ApplicationRecord
  belongs_to :user
  belongs_to :post
  delegate :company, to: :post

  has_many :apply_messages, dependent: :destroy
end
