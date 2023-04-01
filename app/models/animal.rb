class Animal < ApplicationRecord

  # 施設側とのアソシエーション
  belongs_to :facilities

  # 画像を複数投稿
  has_many_attached :images
  def get_images
    unless images.attached?
      file_path = Rails.root.join('app/assets/images/no_facility_image.jpg')
      images.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    images
  end

end
