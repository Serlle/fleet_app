class CreateMaintenanceServices < ActiveRecord::Migration[7.1]
  def change
    create_table :maintenance_services do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.text :description
      t.integer :status, default: 0
      t.date :date, null: false
      t.integer :cost_cents, default: 0, null: false
      t.integer :priority, default: 0
      t.datetime :completed_at

      t.timestamps
    end

    add_index :maintenance_services, :id
    add_index :maintenance_services, :date
    add_index :maintenance_services, :priority
  end
end
