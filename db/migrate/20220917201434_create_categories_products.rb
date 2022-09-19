class CreateCategoriesProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :categories_products, :id => false do |t|
      t.integer :product_id, :category_id
    end
  end
end
