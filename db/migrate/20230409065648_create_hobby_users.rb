class CreateHobbyUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :hobby_users do |t|

      t.timestamps
    end
  end
end
