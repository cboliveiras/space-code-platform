class CreatePilots < ActiveRecord::Migration[7.0]
  def change
    create_table :pilots do |t|
      t.string :name
      t.integer :age
      t.float :credits
      t.string :certification
      t.string :location

      t.timestamps
    end
  end
end
