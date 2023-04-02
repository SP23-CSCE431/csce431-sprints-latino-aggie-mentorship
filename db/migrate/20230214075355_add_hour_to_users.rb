class AddHourToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :hour, :integer
  end
end
