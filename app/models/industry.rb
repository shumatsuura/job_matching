class Industry < ApplicationRecord
  has_many :desired_industries, dependent: :destroy

  h = (1..Industry.count).to_a.map { |n| [Industry.find(n).name.to_sym,n] }.to_h
  h[:Blank] = 0
  enum industry_id: h
end
