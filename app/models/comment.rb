class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :sheet

  validates :text, presence: true
end
