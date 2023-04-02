class CreateMentors < ActiveRecord::Migration[7.0]
  def change
    create_table :mentors do |t|
      t.string :name
      t.integer :hours

      t.timestamps
    end
  end
end
