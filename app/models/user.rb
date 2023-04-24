class User < ApplicationRecord
  has_many :sheets, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :profile_image
  
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { maximum: 20 }
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :password, format: {
    with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i,
    message: 'is invalid. Include both letters and numbers'
  }, on: :create

  validates :introduction, length: { maximum: 200 }

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
