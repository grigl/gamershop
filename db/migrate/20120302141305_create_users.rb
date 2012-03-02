class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :username
      t.string :auth_token
      t.boolean :active, default: false
      t.string :activation_token
      t.string :password_reset_token

      t.timestamps
    end
  end
end
