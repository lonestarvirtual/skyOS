class UninstallAudited < ActiveRecord::Migration[6.0]
  def change
    drop_table :audits, if_exists: true
  end
end
