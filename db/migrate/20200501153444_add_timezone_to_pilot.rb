class AddTimezoneToPilot < ActiveRecord::Migration[6.0]
  def change
    add_column :pilots, :time_zone, :string, default: 'UTC', null: false
  end
end
