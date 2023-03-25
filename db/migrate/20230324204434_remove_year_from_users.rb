class RemoveYearFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :year, :integer
  end
end
