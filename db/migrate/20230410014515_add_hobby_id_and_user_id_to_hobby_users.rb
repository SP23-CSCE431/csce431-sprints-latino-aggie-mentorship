class AddHobbyIdAndUserIdToHobbyUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :hobby_users, :hobby_id, :integer
    add_column :hobby_users, :user_id, :integer
  end
end
