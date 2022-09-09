class CreateImageCollections < ActiveRecord::Migration[7.0]
  def change
    create_table :image_collections do |t|
      t.integer :collection_id
      t.references :product, null: true, foreign_key: true
      t.timestamps
    end
  end
end
