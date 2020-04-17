class CreateGroupPermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :group_permissions, id: :uuid do |t|
      t.references :group, type: :uuid, foreign_key: true
      t.references :permission, type: :uuid, foreign_key: true
    end
  end
end
