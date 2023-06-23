class CreateTravels < ActiveRecord::Migration[7.0]
  def change
    create_table :travels do |t|
      t.string :from_planet
      t.string :to_planet
      t.integer :fuel_consumption
      t.references :ship, foreign_key: true

      t.timestamps
    end
  end
end
