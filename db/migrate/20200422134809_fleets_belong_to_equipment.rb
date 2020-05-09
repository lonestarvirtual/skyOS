class FleetsBelongToEquipment < ActiveRecord::Migration[6.0]
  def change
    remove_index :fleets, [:short_name, :airline_id]

    remove_column :fleets, :icao, :string
    remove_column :fleets, :short_name, :string
    remove_column :fleets, :name, :string
    remove_column :fleets, :description, :string

    add_reference :fleets, :equipment, type: :uuid, index: true
    add_index :fleets, [:airline_id, :equipment_id], unique: true
  end
end
