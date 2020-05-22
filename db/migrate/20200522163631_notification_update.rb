class NotificationUpdate < ActiveRecord::Migration[6.0]
  def up
    remove_reference "notifications", :pilot
    add_column "notifications", :pilot_id, :uuid, null: false
    add_foreign_key "notifications", "pilots"
    add_index :notifications, ["pilot_id", "id"], unique: true
  end

  def down
    remove_index :notifications, name: "index_notifications_on_pilot_id_and_id"
    remove_foreign_key "notifications", "pilots"
    remove_column "notifications", :pilot_id
    add_reference "notifications", "pilot", type: :uuid, null: false, index: true
  end
end
