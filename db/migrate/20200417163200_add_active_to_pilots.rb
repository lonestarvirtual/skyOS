class AddActiveToPilots < ActiveRecord::Migration[6.0]
  def change
    add_column :pilots, :active, :boolean, default: false
  end
end
