class CreateFuelRefills < ActiveRecord::Migration[7.0]
  def change
    create_table :fuel_refills do |t|
      t.references :pilot, null: false, foreign_key: true
      t.integer :fuel
      t.integer :cost
      t.boolean :discounted, default: false

      t.timestamps
    end
  end
end
