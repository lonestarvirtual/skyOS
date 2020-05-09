class CreateFleets < ActiveRecord::Migration[6.0]
  def change
    create_table :fleets, id: :uuid do |t|
      t.string :icao,       null: false
      t.string :short_name, null: false
      t.string :name,       null: false
      t.text   :description
    end
  end
end
