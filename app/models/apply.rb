class Apply < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_many :apply_messages, dependent: :destroy
end
