class Sheet < ApplicationRecord
  belongs_to :user

  has_one_attached :image
  
  validates :title, presence: true
  validates :content, presence: true
  validates :image, presence: true



  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :genre

  validates :genre_id, numericality: { other_than: 0, message: "can't be blank" }
end
