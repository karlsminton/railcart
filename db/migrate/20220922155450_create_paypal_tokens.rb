class CreatePaypalTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :paypal_tokens do |t|
      t.string :access_token
      t.string :app_id
      t.datetime :expires_in
      t.string :nonce

      t.timestamps
    end
  end
end
