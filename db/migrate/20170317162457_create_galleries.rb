class CreateGalleries < ActiveRecord::Migration[5.0]
  def change
    create_table :galleries do |t|
      t.string :title
      t.text :summary
      t.references :user, foreign_key: true
      t.string :main_image

      t.timestamps
    end
  end
end
