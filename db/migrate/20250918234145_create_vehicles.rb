class CreateVehicles < ActiveRecord::Migration[7.1]
  def change
    create_table :vehicles do |t|
      t.string :vin, null: false
      t.string :plate, null: false
      t.string :brand, null: false
      t.string :model, null: false
      t.integer :year, null: false
      t.integer :status, default: 0

      t.timestamps
    end

    add_index :vehicles, :id, unique: true
    add_index :vehicles, :vin, unique: true
    add_index :vehicles, :plate, unique: true
  end
end
