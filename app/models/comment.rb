class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :sheet

  validates :text, presence: true
  validates :text, length: { maximum: 100 }
end
