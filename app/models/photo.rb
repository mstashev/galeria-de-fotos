class Photo < ApplicationRecord
  belongs_to :gallery
  has_one :user, through: :gallery

  mount_uploader :photo, PhotoUploader

  validates :name, :caption, :image, presence: true


  def is_owner?(this_user)
    user == this_user
  end

end
