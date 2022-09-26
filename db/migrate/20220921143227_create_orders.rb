class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :customer, null: true, foreign_key: true
      t.references :address, null: true, foreign_key: true
      t.json :products
      t.decimal :cost, precision: 10, scale: 4
      t.string :paypal_status
      t.string :paypal_id, null: true

      t.timestamps
    end
  end
end
