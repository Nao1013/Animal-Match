class Facility < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  # バリデーション関係
  validates :facility_name, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana, presence: true
  validates :address, presence: true
  validates :address1, presence: true
  validates :telephone, presence: true

  # ゲストログイン
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |facility|
      facility.password = SecureRandom.urlsafe_base64
      facility.facility_name = "施設名"
      facility.first_name = "ゲスト"
      facility.last_name = "ユーザー"
      facility.first_name_kana = "guest"
      facility.last_name_kana = "guest"
      facility.address = "tokyo"
      facility.telephone = "guest"
    end
  end

  def guest?
    email == 'guest@example.com'
  end
  
  # 退会したかどうか
  def active?
    !is_deleted # is_deletedが退会フラグのカラム名
  end
  
  # マップ
  geocoded_by :address
  geocoded_by :address1
  geocoded_by :address2
  after_validation :geocode, if: :address_changed?

  # コメントとのアソシエーション
  has_many :comments, dependent: :destroy

  # animalとのアソシエーション
  has_many :animals, dependent: :destroy

  #DM機能
  has_many :rooms, dependent: :destroy
  has_many :messages, dependent: :destroy

  # プロフィール画像
  has_one_attached :profile_image
  def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def active_for_authentication?
   super && (is_deleted == false)
  end

end
