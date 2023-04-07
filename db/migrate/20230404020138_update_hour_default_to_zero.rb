class UpdateHourDefaultToZero < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :hour, :integer, default: 0
  end
end
