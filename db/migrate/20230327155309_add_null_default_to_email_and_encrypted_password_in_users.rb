class AddNullDefaultToEmailAndEncryptedPasswordInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :email, :string, null: false, default: ""
    change_column :users, :encrypted_password, :string, null: false, default: ""
  end
end
