class ApplyMessage < ApplicationRecord
  belongs_to :apply
  delegate :post, to: :apply

  validates_presence_of :body, :apply_id

  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end
