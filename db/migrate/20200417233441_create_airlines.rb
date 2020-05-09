class CreateAirlines < ActiveRecord::Migration[6.0]
  def change
    create_table :airlines, id: :uuid do |t|
      t.string :icao, null: false
      t.string :iata, null: false
      t.string :name, null: false
    end

    add_index :airlines, :icao, unique: true
  end
end
