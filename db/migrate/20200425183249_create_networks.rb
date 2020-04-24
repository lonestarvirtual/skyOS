class CreateNetworks < ActiveRecord::Migration[6.0]
  def change
    create_table :networks, id: :uuid do |t|
      t.string :name, null: false
    end

    add_index :networks, :name, unique: true

    add_column :pireps, :network_id, :uuid
    add_foreign_key :pireps, :networks, type: :uuid
  end
end
