class Industry < ApplicationRecord
  has_many :desired_industries, dependent: :destroy
end
