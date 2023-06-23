class CreateContractResources < ActiveRecord::Migration[7.0]
  def change
    create_table :contract_resources do |t|
      t.references :resource, null: false, foreign_key: true
      t.references :contract, null: false, foreign_key: true

      t.timestamps
    end
  end
end
