class Language < ApplicationRecord
  belongs_to :user
  enum level: {Native: 1, Fluent: 2, Business: 3, Conversation: 4}
end
