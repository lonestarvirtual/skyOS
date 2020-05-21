class CreateAirports < ActiveRecord::Migration[6.0]
  def change
    create_table :airports, id: :uuid do |t|
      t.string :icao, limit: 4, null: false
      t.string :iata, limit: 3
      t.string :name
      t.string :city
      t.string :time_zone, default: 'UTC', null: false
      t.decimal :latitude, precision: 8, scale: 5
      t.decimal :longitude, precision: 8, scale: 5
    end

    add_index :airports, :icao, unique: true
  end
end
