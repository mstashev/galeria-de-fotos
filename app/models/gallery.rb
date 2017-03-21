class Gallery < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy

  mount_uploader :alt_image, AltImageUploader

  validates :title, :summary, presence: true

  def is_owner?(this_user)
    user == this_user
  end

  def cover_image(version = :standard)
    if alt_image?
      alt_image.versions[version].url
    elsif !main_image.blank?
      main_image
    else
      FFaker::Book.cover
    end
  end
end
