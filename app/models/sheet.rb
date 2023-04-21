class Sheet < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  validates :title, presence: true
  validates :content, presence: true
  validates :image, presence: true

  validates :title, length: { maximum: 50 }
  validates :content, length: { maximum: 300 }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :genre

  validates :genre_id, numericality: { other_than: 0, message: "can't be blank" }
end