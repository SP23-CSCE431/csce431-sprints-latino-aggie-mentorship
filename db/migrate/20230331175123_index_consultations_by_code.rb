class IndexConsultationsByCode < ActiveRecord::Migration[7.0]
  def change
    add_index :consultations, :code, unique: true
  end
end
