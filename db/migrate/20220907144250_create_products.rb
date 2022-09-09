class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.integer :product_id
      t.string :sku
      t.string :name
      t.string :url
      t.decimal :price, precision: 10, scale: 4
      t.boolean :enabled
      t.text :description
      t.integer :stock_qty

      t.timestamps
    end
    add_index :products, :sku, unique: true
    add_index :products, :url, unique: true
  end
end
