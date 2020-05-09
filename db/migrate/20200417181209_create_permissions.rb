class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions, id: :uuid do |t|
      t.string :model,       null: false
      t.string :action,      null: false
      t.string :description, null: false
    end
  end
end
