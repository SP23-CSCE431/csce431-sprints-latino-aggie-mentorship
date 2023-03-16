class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :department
      t.integer :code

      t.timestamps
    end
  end
end
