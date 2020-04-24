class CreatePireps < ActiveRecord::Migration[6.0]
  def change
    create_table :pireps, id: :uuid do |t|
      t.references :pilot, type: :uuid, index: true, null: false, foreign_key: true
      t.date :date, default: -> { 'CURRENT_TIMESTAMP' }, null: false
      t.references :airline, type: :uuid, index: true, null: false, foreign_key: true
      t.integer :flight, limit: 2, null: false
      t.integer :leg, limit: 1, null: false
      t.references :orig, type: :uuid, index: true, null: false, foreign_key: {to_table: :airports}
      t.references :dest, type: :uuid, index: true, null: false, foreign_key: {to_table: :airports}
      t.string :route, null: false
      t.references :equipment, type: :uuid, index: true, null: false, foreign_key: true
      t.references :simulator, type: :uuid, index: true, null: false, foreign_key: true
      t.decimal :duration, precision: 3, scale: 1, null: false
      t.integer :distance, limit: 2, null: false
      t.references :status, type: :uuid, index: true, null: false, foreign_key: {to_table: :pirep_statuses}
      t.timestamps
    end
  end
end
