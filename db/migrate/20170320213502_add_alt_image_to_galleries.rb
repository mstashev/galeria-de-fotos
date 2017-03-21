class AddAltImageToGalleries < ActiveRecord::Migration[5.0]
  def change
    add_column :galleries, :alt_image, :string
  end
end
