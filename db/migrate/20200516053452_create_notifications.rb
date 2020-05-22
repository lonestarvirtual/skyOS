class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications, id: :uuid do |t|
      t.references :pilot, type: :uuid, null: false, index: true
      t.string :title,  null: false
      t.string :body,   null: false
      t.boolean :read,  default: false
      t.datetime :created_at
    end
  end
end
