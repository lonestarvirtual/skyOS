class AddAirlineToFleet < ActiveRecord::Migration[6.0]
  def change
    add_reference :fleets, :airline, type: :uuid, index: true
    add_index :fleets, [:short_name, :airline_id], unique: true
  end
end
