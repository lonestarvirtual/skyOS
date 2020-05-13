class AddIndexToPermission < ActiveRecord::Migration[6.0]
  def change
    add_index :permissions, [:model, :action], unique: true
  end
end
