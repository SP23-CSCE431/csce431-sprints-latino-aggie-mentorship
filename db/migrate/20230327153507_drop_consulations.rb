class DropConsulations < ActiveRecord::Migration[7.0]
  def change
    drop_table :consulations
  end
end
