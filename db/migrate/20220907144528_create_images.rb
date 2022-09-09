class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.integer :image_id
      t.string :name
      t.string :path
      t.string :alt_tag
      t.references :image_collection, null: true, foreign_key: true

      t.timestamps
    end
  end
end
