class CreateContracts < ActiveRecord::Migration[7.0]
  def change
    create_table :contracts do |t|
      t.text :description
      t.string :from_planet
      t.string :to_planet
      t.float :value
      t.string :status, default: 'OPEN'
      t.references :ship, foreign_key: true

      t.timestamps
    end
  end
end
