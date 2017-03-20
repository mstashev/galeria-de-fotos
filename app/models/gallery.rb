class Gallery < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy

  validates :title, :summary, :main_image, presence: true

  def is_owner?(this_user)
    user == this_user
  end
end
