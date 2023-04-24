class Sheet < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_one_attached :image

  validates :image, presence: true
  validates :genre_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :title, presence: true
  validates :title, length: { maximum: 50 }
  validates :content, presence: true
  validates :content, length: { maximum: 300 }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :genre

  def self.search(search)
    if search != ''
      Sheet.where('title LIKE(?)', "%#{search}%").order('created_at DESC')
    else
      Sheet.includes(:user).order('created_at DESC')
    end
  end
end
