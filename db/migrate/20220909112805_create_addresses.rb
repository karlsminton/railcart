class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :house
      t.string :street
      t.string :postcode
      t.string :town
      t.string :country
      t.references :customer, null: true, foreign_key: true

      t.timestamps
    end
  end
end
