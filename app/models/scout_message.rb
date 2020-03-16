class ScoutMessage < ApplicationRecord
  belongs_to :scout
  # belongs_to :company
  # belongs_to :user

  validates_presence_of :body, :scout_id

  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end
