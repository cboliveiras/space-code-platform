class CreateShips < ActiveRecord::Migration[7.0]
  def change
    create_table :ships do |t|
      t.float :fuel_capacity
      t.float :fuel_level
      t.float :weight_capacity
      t.references :pilot, foreign_key: true

      t.timestamps
    end
  end
end
