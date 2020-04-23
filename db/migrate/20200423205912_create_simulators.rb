class CreateSimulators < ActiveRecord::Migration[6.0]
  def change
    create_table :simulators, id: :uuid do |t|
      t.string :short_name, limit: 15
      t.string :name
    end

    add_index :simulators, :short_name, unique: true
    add_index :simulators, :name, unique: true
  end
end
