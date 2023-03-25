class RemoveNameAndStatusFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :name, :string
    remove_column :users, :status, :string
  end
end
