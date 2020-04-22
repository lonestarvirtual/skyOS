class CreateFlights < ActiveRecord::Migration[6.0]
  def change
    create_table :flights, id: :uuid do |t|
      t.references :airline, type: :uuid, index: true, null: false, foreign_key: true
      t.references :equipment, type: :uuid, index: true, null: false, foreign_key: true
      t.integer :number, limit: 2, null: false
      t.integer :leg, limit: 1, null: false, default: 1
      t.references :orig, type: :uuid, index: true, null: false, foreign_key: {to_table: :airports}
      t.references :dest, type: :uuid, index: true, null: false, foreign_key: {to_table: :airports}
      t.time :out_time, null: false
      t.time :in_time, null: false
      t.decimal :duration, precision: 3, scale: 1, null: false
      t.integer :distance, limit: 2, null: false
      t.string :slug, null: false
    end

    add_index :flights, :slug, unique: true
    add_index :flights, [:airline_id, :number, :leg], unique: true
  end
end
