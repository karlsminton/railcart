class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :password_digest
      t.boolean :enabled

      t.timestamps
    end
  end
end
