class CreateEquipment < ActiveRecord::Migration[6.0]
  def change
    create_table :equipment, id: :uuid do |t|
      t.string :short_name, null: false
      t.string :icao, limit: 4, null: false
      t.string :iata, limit: 3
      t.string :name, null: false
      t.text   :description
    end

    add_index :equipment, :short_name, unique: true
  end
end
