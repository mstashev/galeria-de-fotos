class User < ApplicationRecord
  has_many :galleries
  has_many :photos, through: :galleries

  has_secure_password

  mount_uploader :profile_pic, UserUploader

  validates :name, :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
  validates :avatar, require: false

  def to_s
    username
  end

  def personage(version = :standard)
    if profile_pic?
      profile_pic.versions[version].url
    elsif !avatar.blank?
      avatar
    else
      FFaker::Avatar.image
    end
  end
end
