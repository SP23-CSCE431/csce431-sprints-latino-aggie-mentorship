class AddPointsToConsultations < ActiveRecord::Migration[7.0]
  def change
    add_column :consultations, :event_points, :integer
  end
end
