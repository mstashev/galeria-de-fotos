class Photo < ApplicationRecord
  belongs_to :gallery
  has_one :user, through: :gallery

  mount_uploader :photo, PhotoUploader

  default_scope {order ('created_at ASC') }

  validates :name, :caption, presence: true


  def is_owner?(this_user)
    user == this_user
  end

end
