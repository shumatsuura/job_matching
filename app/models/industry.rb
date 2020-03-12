class Industry < ApplicationRecord
  has_many :desired_industries, dependent: :destroy

  h = (1..Industry.count).to_a.map { |n| [Industry.find(n).name.to_sym,n] }.to_h
  enum industry_id: h

  # enum industry_id: {blank: 0, Construction: 1, Medical: 2}
end
