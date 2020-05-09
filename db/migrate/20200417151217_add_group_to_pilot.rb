class AddGroupToPilot < ActiveRecord::Migration[6.0]
  def change
    add_reference :pilots, :group, type: :uuid, index: true
    add_foreign_key :pilots, :groups
  end
end
