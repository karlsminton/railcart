class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.integer :category_id
      t.string :name
      t.string :url
      t.text :description
      t.references :product, null: true, foreign_key: true

      t.timestamps
    end
    add_index :categories, :url, unique: true
  end
end
